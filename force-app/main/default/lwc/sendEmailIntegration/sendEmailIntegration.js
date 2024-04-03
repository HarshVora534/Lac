import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import GmailIntegration from '@salesforce/apex/GmailIntegrationController.GmailIntegration';

const fields= ['Contact.Id'];
console.log(fields);
export default class SendEmailIntegration extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: ['Contact.Id'] }) contact;

    @track input;
    @track text;
    acceptedFormats = ['.pdf', '.png', '.jpg', '.jpeg'];
    modalVisible = false;
    uploadedFiles=[];

    inputChange(event) {
        this.input = event.target.value;
    }

    textChange(event) {
        this.text = event.target.value;
    }

    handleUploadFinished(event) {
        this.uploadedFiles = event.detail.files.map(file => file.documentId);
        console.log('Uploaded Files:',this.uploadedFiles);
    }

    handleSubmit() {
        this.modalVisible = true;
    }

    handleSend() {
        console.log('Sending email for Contact Id:', this.recordId);
        GmailIntegration({ contactId: this.recordId,
                            subject: this.input,
                            body: this.text,
                            attachments: this.uploadedFiles})
            .then(result => {
                console.log('Email sent successfully:', result);
            })
            .catch(error => {
                console.error('Error sending email:', error);
            });
        this.modalVisible = false;
    }
}