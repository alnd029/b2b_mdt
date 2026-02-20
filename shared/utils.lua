-- Shared utility helpers
Utils = {}
function Utils.UUID() local t='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx' return string.gsub(t,'[xy]',function(c) local v=(c=='x') and math.random(0,0xf) or math.random(8,0xb) return string.format('%x',v) end) end
return Utils
