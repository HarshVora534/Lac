// import { LightningElement,api,wire,track } from 'lwc';
// import { getRecord } from 'lightning/uiRecordApi';
// import GmailIntegration from '@salesforce/apex/GmailIntegrationController.GmailIntegration';
// const fields= ['Contact.Id'];
// console.log(fields);

// export default class SendEmailIntegration extends LightningElement {

//     @api recordId;
//     @wire(getRecord, { recordId: '$recordId', fields: fields }) contact;

//     @track input;
//     @track file;
//     @track text;

//     acceptedFormats = ['.pdf', '.png', '.jpg', '.jpeg'];
//     modalVisible=false;

//     inputChange(event)
//     {
//         this.input=event.target.value;
//         console.log(this.input);
//     }

//     textChange(event)
//     {
//         this.text=event.target.value;
//         console.log(this.text);
//     }

//     // fileChange(event)
//     // {
//     //     this.file=event.target.value;
//     //     console.log(this.file);
//     // }

//     handleUploadFinished(event)
//     {
//         const uploadFinish=event.details.files;
//         console.log(uploadFinish);
//     }

//     handleSubmit()
//     {
//         this.modalVisible=true;
//     }
//     handleSend()
//     {
//         console.log(this.recordId);
//         GmailIntegration({ContactId : this.recordId})
//         .then(result =>
//             {
//                 console.log('success');
//             })
//             .catch(error =>
//                 {
//                     console.log('error');
//                 })
//         this.modalVisible=false;
//     }
// }


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

    inputChange(event) {
        this.input = event.target.value;
    }

    textChange(event) {
        this.text = event.target.value;
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        console.log('Uploaded Files:', uploadedFiles);
    }

    handleSubmit() {
        this.modalVisible = true;
    }

    handleSend() {
        console.log('Sending email for Contact Id:', this.recordId);
        GmailIntegration({ ContactId: this.recordId })
            .then(result => {
                console.log('Email sent successfully:', result);
            })
            .catch(error => {
                console.error('Error sending email:', error);
            });
        this.modalVisible = false;
    }
}
