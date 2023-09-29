const fs = require('fs')
const path = require('path')
const https = require('https')

const config = require('./npp-plugins-generate-config')
const templateDir = __dirname + '/.npp-plugins-generate-template'

async function executeLogic() {
    function processPlugins(plugins, bits) {
        plugins['npp-plugins'].forEach(plugin => {
            config.forEach(packageConfig => {
                if (packageConfig.id === plugin['folder-name']) {
                    packageConfig.version = packageConfig.version ?? plugin['version']
                    packageConfig[`url${bits}`] = plugin['repository']
                    packageConfig[`url${bits}Checksum`] = plugin['id']
                }
            })
        })
    }

    const plugins64 = JSON.parse(await getHttp('https://github.com/notepad-plus-plus/nppPluginList/raw/master/src/pl.x64.json'))
    processPlugins(plugins64, 64)

    const plugins32 = JSON.parse(await getHttp('https://github.com/notepad-plus-plus/nppPluginList/raw/master/src/pl.x86.json'))
    processPlugins(plugins32, 32)

    //console.log('config', config)

    config.forEach((packageConfig, packageIndex) => {
        const packageName = packageConfig.packageName

        if (packageIndex >= 1) { console.log('') }
        console.log(`Generating ${packageName} package`)

        const packageDir = __dirname + '/' + packageName
        if (fs.existsSync(packageDir)) {
            //console.log(`Removing ${packageDir}`)
            fs.rmSync(packageDir, { recursive: true, force: true })
        }

        function substitute(string) {
            return string
                .replaceAll('#PACKAGE#', packageName)
                .replaceAll('#ID#', packageConfig.id)
                .replaceAll('#VERSION#', packageConfig.version ?? '')
                .replaceAll('#URL_64#', packageConfig.url64 ?? '')
                .replaceAll('#URL_64_CHECKSUM#', packageConfig.url64Checksum ?? '')
                .replaceAll('#URL_32#', packageConfig.url32 ?? '')
                .replaceAll('#URL_32_CHECKSUM#', packageConfig.url32Checksum ?? '')
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
    })

    process.exit(0)
}

executeLogic()

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

function getHttp(url) {
    return new Promise((resolve, reject) => {
        const body = []
        function callback(response) {
            if (301 <= response.statusCode && response.statusCode <= 302) {
                send(response.headers.location);
                return
            }

            if (response.statusCode !== 200) {
                reject(`Status code: ${response.statusCode}`)
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
