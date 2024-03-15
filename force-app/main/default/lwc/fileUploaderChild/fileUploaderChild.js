import { LightningElement, api } from 'lwc';

export default class InputFileUploadPDF extends LightningElement {
    fileName = '';
    @api fileUrl = '';
    handleFileUpload(event) {
        const file = event.target.files[0];
        this.fileName = file.name;
        this.fileUrl = URL.createObjectURL(file);
    }
}