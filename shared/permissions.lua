-- Shared permission helpers for bridge logic.
Permissions = {}
function Permissions.Has(role,perm) local perms=Config.Roles[role] or {} for _,p in ipairs(perms) do if p=='*' or p==perm then return true end end return false end
return Permissions
