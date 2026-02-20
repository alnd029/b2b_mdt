// Frontend sanitizers before posting to server callbacks.
export const sanitizeString=v=>String(v??'').replace(/[<>]/g,'').trim();
export const sanitizeNumber=v=>Number.isFinite(Number(v))?Number(v):0;
