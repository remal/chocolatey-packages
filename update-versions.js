const fs = require('fs')

RegExp.escape = function(text) {
    return text.replaceAll(/[[\]{}()*+?.\\^$|]/g, "\\$&");
}

const version = Math.floor(Date.now() / 1000)
const fullVersion = `${version}.0.0`

const packageNames = fs.readFileSync('changed-packages.tmp.txt', 'utf8').split(/[\n\r]+/)
    .map(it => it.trim())
    .filter(it => !!it.length)
    .filter(packageName => fs.existsSync(`${packageName}/${packageName}.nuspec`))

packageNames.forEach(packageName => {
    console.log(`Setting version of ${packageName} to ${fullVersion}`)
    const packageNuspecFile = `${packageName}/${packageName}.nuspec`

    let content = fs.readFileSync(packageNuspecFile, 'utf8').replace(/^\uFEFF/, '')
    content = content.replace(/<version>[\s\S]*?<\/version>/, `<version>${fullVersion}</version>`)

    const dependenciesRegEx = new RegExp(`<dependency\\s+id="((${packageNames.map(RegExp.escape).join(')|(')}))"(\\s+version="[^"]*")?\\s*\\/>`, 'g')
    content = content.replaceAll(dependenciesRegEx, `<dependency id="$1" version="${fullVersion}" />`)

    fs.writeFileSync(packageNuspecFile, '\uFEFF' + content, 'utf8')


    const versionFile = `${packageName}/${packageName}.nuspec.version.tmp`
    fs.writeFileSync(versionFile, fullVersion, 'utf8')
})
