import fs from 'fs';
import assert from 'assert';
const samplePath='examples/report_example.json';
assert(fs.existsSync(samplePath),'report_example missing');
const report=JSON.parse(fs.readFileSync(samplePath,'utf8'));
assert(report.id && report.charges.length>0 && report.totals.total_fine>0);
console.log('integration_save.test.js passed');
