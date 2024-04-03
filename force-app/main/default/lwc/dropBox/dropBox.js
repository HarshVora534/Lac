import { LightningElement } from 'lwc';
import dropbox from '@salesforce/apex/dropbox.dropboxfiles';
export default class DropBox extends LightningElement {

    acceptedFormats = ['.pdf', '.png', '.jpg', '.jpeg'];
    uploadedFiles=[];

    handleUploadFinished(event) {
        this.uploadedFiles = event.detail.files.map(file => file.documentId);
        console.log('Uploaded Files:',this.uploadedFiles);
        dropbox({files:this.uploadedFiles})
        .then(result => {
            console.log('File sent successfully:', result);
        })
        .catch(error => {
            console.error('Error sending File:', error);
        });
    }
}