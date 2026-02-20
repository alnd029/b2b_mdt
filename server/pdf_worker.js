// Optional Node worker for PDF exports via jsPDF.
import fs from 'fs';
import { jsPDF } from 'jspdf';
export function exportReportPDF(report,path){const doc=new jsPDF();doc.text(`Report ${report.id}`,10,10);doc.text(`Title: ${report.title}`,10,20);doc.text(`Total fine: $${report.totals?.total_fine||0}`,10,30);doc.text(`Total months: ${report.totals?.total_months||0}`,10,40);fs.writeFileSync(path,Buffer.from(doc.output('arraybuffer')));}
