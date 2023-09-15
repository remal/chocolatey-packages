const fs = require('fs')


const existingWorkflowFiles = fs.readdirSync('./.github/workflows')
    .filter(file => !file.startsWith('.'))
    .filter(file => file.startsWith('build-') && file.endsWith('.yml'))
    .map(file => '.github/workflows/' + file)
    .filter(file => fs.statSync(file).isFile())

existingWorkflowFiles.forEach(file => fs.unlinkSync(file))


const template = fs.readFileSync('./.github/workflows/templates/build-package.yml', 'utf8')

const packageNames = fs.readdirSync('.')
    .filter(file => !file.startsWith('.'))
    .filter(file => fs.statSync(file).isDirectory())

packageNames.forEach(packageName => {
    const workflow = template.replaceAll('{package}', packageName)
    fs.writeFileSync(`./.github/workflows/build-${packageName}.yml`, workflow, 'utf8')
});
