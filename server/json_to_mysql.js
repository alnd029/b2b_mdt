// JSON -> MySQL migration script (run separately with node).
import fs from 'fs';
import path from 'path';
import mysql from 'mysql2/promise';
const conn=await mysql.createConnection({host:'127.0.0.1',user:'root',password:'',database:'fivem'});
const playersDir=path.resolve('data/players');
if(fs.existsSync(playersDir)){for(const identifier of fs.readdirSync(playersDir)){const reportsDir=path.join(playersDir,identifier,'reports');if(!fs.existsSync(reportsDir)) continue;for(const file of fs.readdirSync(reportsDir)){const payload=fs.readFileSync(path.join(reportsDir,file),'utf8');const obj=JSON.parse(payload);await conn.execute('REPLACE INTO mdt_reports (id,identifier,payload,status,created_at,updated_at) VALUES (?,?,?,?,NOW(),NOW())',[obj.id||file,identifier,payload,obj.status||'draft']);}}}
await conn.end();
console.log('Migration done');
