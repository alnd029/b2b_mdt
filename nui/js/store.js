// Lightweight global store (Redux-like) for b2b_mdt.
const state={section:'reports',reports:[],citizens:[],vehicles:[],weapons:[],templates:[],audit:[],activeReport:null,notifications:[]};
const listeners=new Set();
export function getState(){return state;}
export function setState(partial){Object.assign(state,partial);listeners.forEach(fn=>fn(state));}
export function subscribe(fn){listeners.add(fn);return()=>listeners.delete(fn);}
