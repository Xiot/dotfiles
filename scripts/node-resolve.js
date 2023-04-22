import {createRequire} from 'node:module';
import path from 'node:path';
import fs from 'node:fs';

const [name] = process.argv.slice(2);
const require = createRequire(path.join(process.cwd(), 'index.js'));

try {
  const resolved = require.resolve(name);
  console.log('r', resolved)
  const manifestFile = findPackageJson(resolved);
  
  const version = findPackageVersion(manifestFile)
  const manifest = readManifest(manifestFile)

  console.log(`${manifest.name}@${manifest.version}`)
  console.log('---------------------------------------')
  console.log(`resolved:  ${resolved}`)
  console.log(`base:      ${path.dirname(manifestFile)}`)
  
} catch (ex) {
  console.log(`${name}: <not found>`)
  console.error(ex)
}
function readManifest(manifestFile) {
  if (manifestFile == null) return {name: 'unknown', version: 'unknown'};
  const contents = fs.readFileSync(manifestFile, 'utf-8');
  return JSON.parse(contents)
}

function findPackageName(manifestFile) {
  if (manifestFile == null) return 'unknown';
  const contents = fs.readFileSync(manifestFile, 'utf-8');
  return JSON.parse(contents).name
}
function findPackageVersion(manifestFile) {
  if (manifestFile == null) return 'unknown';
  const contents = fs.readFileSync(manifestFile, 'utf-8');
  return JSON.parse(contents).version
}

function findPackageJson(start) {
  let current = start;
  while(true) {
    if (current === '/') return null;

    const packageManifest = path.join(current, 'package.json');
    if (fs.existsSync(packageManifest)) {
      return packageManifest  
    }

    current = path.dirname(current);
  }
}