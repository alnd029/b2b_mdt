import assert from 'assert';
import { calculateReportTotals } from '../nui/js/utils/calculator.js';
const charges=[{code:'VOL_QUALIFIE',base_fine:1000,min_fine:500,max_fine:5000,base_months:12,months_per_prior:2,recidive_multiplier:1.5},{code:'USAGE_ARME',base_fine:1200,min_fine:600,max_fine:5500,base_months:10,months_per_prior:1,recidive_multiplier:1.2}];
const result=calculateReportTotals(charges,{numPriors:2,recidiveCodes:new Set(['VOL_QUALIFIE']),comboRules:[{requires:['VOL_QUALIFIE','USAGE_ARME'],fineMultiplier:1.5,monthsMultiplier:1.5,reason:'combo'}]});
assert(result.total_fine>0);assert(result.total_months>0);assert(result.breakdown.some(b=>b.type==='combo'));
console.log('calc.test.js passed');
