
import fs from 'fs';
import process from 'process';

const source = process.argv[2];

const contents = fs.readFileSync(source, 'utf-8')
    .replace(/\$([a-z0-9_]+)/gi, (_,name) => {
        const v = process.env[name];
        return process.env[name] ?? `$${name}`
    });
    
process.stdout.write(contents);
