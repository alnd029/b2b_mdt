// Date formatting utilities used by timeline and audit log.
export function isoNow(){return new Date().toISOString();}
export function formatDate(date){const d=new Date(date);return d.toLocaleString('fr-FR');}
