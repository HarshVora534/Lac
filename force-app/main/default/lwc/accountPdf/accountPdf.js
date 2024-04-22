// import { LightningElement } from 'lwc';
// import generatePDFs from '@salesforce/apex/AccountPDFController.generatePDFs';

// export default class AccountPdf extends LightningElement {
//     handleDownload() {
//         generatePDFs()
//             .then(result => {
//                 result.forEach((pdfBlob, index) => {
//                     const url = window.URL.createObjectURL(new Blob([pdfBlob], { type: 'application/pdf' }));
//                     const a = document.createElement('a');
//                     a.href = url;
//                     a.download = `example_${index + 121}.pdf`; // Custom filename with index
//                     document.body.appendChild(a);
//                     a.click();
//                     window.URL.revokeObjectURL(url);
//                 });
//             })
//             .catch(error => {
//                 console.error('Error: ', error);
//             });
//     }
// }

import { LightningElement } from 'lwc';
import generatePDFs from '@salesforce/apex/AccountPDFController.generatePDFs';

export default class AccountPdf extends LightningElement {
    handleDownload() {
        generatePDFs()
            .then(result => {
                result.forEach((pdfBlob, index) => {
                    const url = window.URL.createObjectURL(new Blob([pdfBlob], { type: 'application/pdf' }));
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = `example_${index + 121}.pdf`; // Custom filename with index
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                });
            })
            .catch(error => {
                console.error('Error: ', error);
            });
    }
}



// import { LightningElement } from 'lwc';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import generatePDFs from '@salesforce/apex/AccountPDFController.generatePDFs';

// export default class AccountPdf extends LightningElement {
//     handleDownload() {
//         // Create an array of Account IDs (replace these with actual IDs)
//         const accountIds = ['001xxxxxxxxxxxxxxx', '001yyyyyyyyyyyyyyy', '001zzzzzzzzzzzzzzz'];

//         generatePDFs({ accountIds: accountIds })
//             .then(result => {
//                 result.forEach((pdfBlob, index) => {
//                     const url = window.URL.createObjectURL(new Blob([pdfBlob], { type: 'application/pdf' }));
//                     const a = document.createElement('a');
//                     a.href = url;
//                     a.download = `account_pdf_${index + 1}.pdf`; // Custom filename with index
//                     document.body.appendChild(a);
//                     a.click();
//                     window.URL.revokeObjectURL(url);
//                 });
//             })
//             .catch(error => {
//                 console.error('Error: ', error);
//                 this.showToast('Error', 'Failed to generate PDFs', 'error');
//             });
//     }

//     showToast(title, message, variant) {
//         const event = new ShowToastEvent({
//             title: title,
//             message: message,
//             variant: variant,
//         });
//         this.dispatchEvent(event);
//     }
// }










// import { LightningElement, wire } from 'lwc';
// import generatePDFs from '@salesforce/apex/AccountPDFController.generatePDFs';

// export default class AccountPdf extends LightningElement {
//     @wire(generatePDFs)
//     pdfBlobs;

//     handleDownload() {
//         if (this.pdfBlobs && this.pdfBlobs.data) {
//             this.pdfBlobs.data.forEach((pdfBlob, index) => {
//                 const url = window.URL.createObjectURL(new Blob([pdfBlob], { type: 'application/pdf' }));
//                 const a = document.createElement('a');
//                 a.href = url;
//                 a.download = `example_${index + 121}.pdf`; // Custom filename with index
//                 document.body.appendChild(a);
//                 a.click();
//                 window.URL.revokeObjectURL(url);
//             });
//         }
//     }
// }



// import { LightningElement, api, wire } from 'lwc';
// import generatePDFs from '@salesforce/apex/AccountPDFController.generatePDFs';

// export default class AccountPdf extends LightningElement {
//     @api recordId;

//     handleDownload() {
//         generatePDFs({ recordId: this.recordId })
//             .then(result => {
//                 if (result && Array.isArray(result)) {
//                     result.forEach((pdfBlob, index) => {
//                         const url = window.URL.createObjectURL(new Blob([pdfBlob], { type: 'application/pdf' }));
//                         const a = document.createElement('a');
//                         a.href = url;
//                         a.download = `example_${index + 121}.pdf`; // Custom filename with index
//                         document.body.appendChild(a);
//                         a.click();
//                         window.URL.revokeObjectURL(url);
//                     });
//                 }
//             })
//             .catch(error => {
//                 console.error('Error: ', error);
//             });
//     }
// }
