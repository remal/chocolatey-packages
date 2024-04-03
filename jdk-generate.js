const fs = require('fs')
const path = require('path')
const https = require('https')

const templateDir = __dirname + '/.jdk-generate-template'
const templateMainDir = __dirname + '/.jdk-generate-main-template'

const versionsToGenerate = (process.env.JDK_VERSIONS_TO_GENERATE || process.argv[2] || '')
    .split(/,/g)
    .map(it => it.trim())
    .filter(it => !!it.length)

const versionsPageSize = 50

async function executeLogic() {
    const allVersions = {}
    for (let pageNumber = 0; pageNumber <= 10000; ++pageNumber) {
        const pageContent = await getHttp(`https://api.adoptium.net/v3/info/release_versions?image_type=jdk&vendor=eclipse&release_type=ga&semver=false&sort_method=DATE&sort_order=DESC&page_size=${versionsPageSize}&page=${pageNumber}`)
        if (pageContent == null) {
            break
        }

        const page = JSON.parse(pageContent)
        const pageVersions = page.versions ?? []
        pageVersions.forEach(version => {
            const major = version.major | 0
            const versionsForMajor = allVersions[major] = allVersions[major] ?? []
            if (!versionsForMajor.includes(version.semver)) {
                versionsForMajor.push(version.semver)
            }
        })

        if (pageVersions.length < versionsPageSize) {
            break
        }
    }

    const majorVersions = Object.keys(allVersions)
    const installers64 = []
    const installers32 = []
    for (let majorVersionIndex = 0; majorVersionIndex < majorVersions.length; ++majorVersionIndex) {
        const majorVersion = majorVersions[majorVersionIndex] | 0
        const fullVersion = allVersions[majorVersion][0]
        //console.log('fullVersion', fullVersion)
        const versionRange = `[${fullVersion.replace(/\+.*/, '')},${majorVersion + 1})`
        //console.log('versionRange', versionRange)
        const versionRangeEncoded = encodeURIComponent(versionRange)

        const assetsContent = await getHttp(`https://api.adoptium.net/v3/assets/version/${versionRangeEncoded}?semver=false&os=windows&vendor=eclipse&release_type=ga&heap_size=normal&image_type=jdk&jvm_impl=hotspot&project=jdk&sort_method=DATE&sort_order=DESC&page_size=20&page=0`)
        const assets = JSON.parse(assetsContent)

        const installer64 = assets.flatMap(it => it.binaries)
            .filter(it => it.architecture === 'x64')
            .map(it => it.installer)
            [0]
        //console.log('installer64', installer64)
        installers64[majorVersion] = installer64

        const installer32 = assets.flatMap(it => it.binaries)
            .filter(it => it.architecture === 'x32')
            .map(it => it.installer)
            [0]
        //console.log('installer32', installer32)
        installers32[majorVersion] = installer32

        if (installer64 == null && installers32 == null) {
            delete allVersions[majorVersion]
        }
    }

    Object.keys(allVersions).forEach((majorVersion, majorVersionIndex) => {
        if (!!versionsToGenerate.length && !versionsToGenerate.includes(majorVersion)) {
            return
        }

        const fullVersion = allVersions[majorVersion][0]

        {
            const packageName = `remal-jdk${majorVersion}`

            if (majorVersionIndex >= 1) { console.log('') }
            console.log(`Generating ${packageName} package`)

            const packageDir = __dirname + '/' + packageName
            if (fs.existsSync(packageDir)) {
                //console.log(`Removing ${packageDir}`)
                fs.rmSync(packageDir, { recursive: true, force: true })
            }

            const installer64 = installers64[majorVersion]
            const installer32 = installers32[majorVersion]

            function substitute(string) {
                return string
                    .replaceAll('#PACKAGE#', packageName)
                    .replaceAll('#MAJOR_VERSION#', majorVersion)
                    .replaceAll('#VERSION#', fullVersion)
                    .replaceAll('#URL_64#', installer64?.link ?? '')
                    .replaceAll('#URL_64_CHECKSUM#', installer64?.checksum ?? '')
                    .replaceAll('#URL_32#', installer32?.link ?? '')
                    .replaceAll('#URL_32_CHECKSUM#', installer32?.checksum ?? '')
            }

            getAllFiles(templateDir)
                .forEach(sourceFile => {
                    let content = fs.readFileSync(sourceFile, 'utf-8')
                    content = substitute(content)

                    const targetFile = packageDir + substitute(sourceFile.substring(templateDir.length))
                    const targetDir = path.dirname(targetFile)
                    fs.mkdirSync(targetDir, { recursive: true })

                    fs.writeFileSync(targetFile, content, 'utf-8')
                })

            fs.appendFileSync('changed-packages.tmp.txt', '\n\n' + packageName, 'utf8')
        }

        {
            const packageName = `remal-jdk${majorVersion}-main`

            console.log('')
            console.log(`Generating ${packageName} package`)

            const packageDir = __dirname + '/' + packageName
            if (fs.existsSync(packageDir)) {
                //console.log(`Removing ${packageDir}`)
                fs.rmSync(packageDir, { recursive: true, force: true })
            }

            function substitute(string) {
                return string
                    .replaceAll('#PACKAGE#', packageName)
                    .replaceAll('#MAJOR_VERSION#', majorVersion)
                    .replaceAll('#VERSION#', fullVersion)
            }

            getAllFiles(templateMainDir)
                .forEach(sourceFile => {
                    let content = fs.readFileSync(sourceFile, 'utf-8')
                    content = substitute(content)

                    const targetFile = packageDir + substitute(sourceFile.substring(templateMainDir.length))
                    const targetDir = path.dirname(targetFile)
                    fs.mkdirSync(targetDir, { recursive: true })

                    fs.writeFileSync(targetFile, content, 'utf-8')
                })

            fs.appendFileSync('changed-packages.tmp.txt', '\n\n' + packageName, 'utf8')
        }
    })

    process.exit(0)
}

executeLogic()

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

function getHttp(url, ignore404) {
    return new Promise((resolve, reject) => {
        const body = []
        function callback(response) {
            if (301 <= response.statusCode && response.statusCode <= 302) {
                send(response.headers.location)
                return
            }

            if (!!ignore404 && response.statusCode === 404) {
                resolve(null)
                return
            }

            if (response.statusCode !== 200) {
                reject(new Error(`${url}: status code: ${response.statusCode}`))
                return
            }

            response.on('data', chunk => {
                body.push(chunk)
            })
            response.on('end', () => {
                response.body = Buffer.concat(body)
                resolve(response)
            })
        }

        function send(url) {
            //console.log('url', url)
            const request = https.request(url, callback)
            request.on('error', e => reject(e))
            request.end()
        }
        send(url)
    }).then(response => response.body.toString('utf-8'))
}

function getAllFiles(dir, isFirst) {
    let results = []
    const list = fs.readdirSync(dir)
    list.forEach(file => {
        if (file === '.' || file === '..') {
            return
        }

        file = dir + '/' + file
        var stat = fs.statSync(file)
        if (stat.isDirectory()) {
            results = results.concat(getAllFiles(file))
        } else {
            results.push(file)
        }
    })
    return results
}
