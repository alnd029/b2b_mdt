// NUI <-> FiveM bridge helpers.
export async function nui(event,payload={}){const res=await fetch(`https://b2b_mdt/${event}`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)});return res.json();}
export const Api={saveReport:(report)=>nui('saveReport',report),search:(query)=>nui('search',query),getCitizen:(identifier)=>nui('getCitizen',{identifier}),linkVehicle:(payload)=>nui('linkVehicle',payload),linkWeapon:(payload)=>nui('linkWeapon',payload),exportPDF:(payload)=>nui('exportPDF',payload)};
