const fs = require('fs')

const version = Math.floor(Date.now() / 1000)
const packageName = process.argv[2]
if (packageName == null || packageName.length == 0) {
    throw new Error('Empty package name')
}

const packageNuspecFile = `${packageName}/${packageName}.nuspec`
let content = fs.readFileSync(packageNuspecFile, 'utf8').replace(/^\uFEFF/, '')

content = content.replace(/<version>[\s\S]*?<\/version>/, `<version>${version}.0.0</version>`)

fs.writeFileSync(packageNuspecFile, '\uFEFF' + content, 'utf8')
