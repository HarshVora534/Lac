// import { LightningElement, api } from 'lwc';

// export default class InputFileUploadPDF extends LightningElement {
//     fileName = '';
//     @api fileUrl = '';
//     handleFileUpload(event) {
//         const file = event.target.files[0];
//         this.fileName = file.name;
//         this.fileUrl = URL.createObjectURL(file);
//     }
// }

import { LightningElement } from 'lwc';

export default class FileUploaderChild extends LightningElement {
    fileName = '';

    handleFileUpload(event) {
        const file = event.target.files[0];
        this.fileName = file.name;

        const fileSelectedEvent = new CustomEvent('fileselected', {
            detail: { file },
        });
        this.dispatchEvent(fileSelectedEvent);
    }
}
