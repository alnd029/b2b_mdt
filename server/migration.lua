-- Migration helper executed from server console.
RegisterCommand('b2b_mdt_migrate_json_mysql', function(src) if src~=0 then return end print('[b2b_mdt] Start migration JSON -> MySQL') -- TODO iterate data folders and insert rows using oxmysql. end, true)
