#!/usr/bin/env node

import rl from 'readline'

const args = process.argv.slice(2)

// const rl = require('readline/promises');

const re = new RegExp(args[0])

const w = rl.createInterface(process.stdin);
w.addListener('line', data => {
  const m = re.exec(data)
  if (!m) return;
  process.stdout.write(m[1] ?? m[0])
  process.stdout.write('\n')
})