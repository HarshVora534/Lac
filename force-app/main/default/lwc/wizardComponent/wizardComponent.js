import { LightningElement, track } from 'lwc';
import getObjectRecords from '@salesforce/apex/WizardController.getObjectRecords';
import draftEmail from '@salesforce/apex/WizardController.draftEmail';
import sendEmail from '@salesforce/apex/WizardController.sendEmail';

export default class WizardComponent extends LightningElement {
    @track sectionOneVisible = true;
    @track sectionTwoVisible = false;
    @track sectionThreeVisible = false;
    @track objectOptions = [{ label: 'Lead', value: 'Lead' }, { label: 'Account', value: 'Account' }, { label: 'Contact', value: 'Contact' }];
    @track selectedObject;
    @track objectRecords;
    @track selectedRecords = [];
    @track emailDraft;
    @track disablePrevious = true;

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' }
    ];

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.fetchObjectRecords();
    }

    async fetchObjectRecords() {
        this.objectRecords = await getObjectRecords({ objectName: this.selectedObject });
    }

    handleRowSelection(event) {
        this.selectedRecords = event.detail.selectedRows;
    }

    handleEmailDraft(event) {
        this.emailDraft = event.target.value;
    }

    handleNext() {
        if (this.sectionOneVisible) {
            this.sectionOneVisible = false;
            this.sectionTwoVisible = true;
        } else if (this.sectionTwoVisible) {
            this.sectionTwoVisible = false;
            this.sectionThreeVisible = true;
        }
        this.disablePrevious = false;
    }

    handlePrevious() {
        if (this.sectionTwoVisible) {
            this.sectionTwoVisible = false;
            this.sectionOneVisible = true;
        } else if (this.sectionThreeVisible) {
            this.sectionThreeVisible = false;
            this.sectionTwoVisible = true;
        }
        if (!this.sectionTwoVisible) {
            this.disablePrevious = true;
        }
    }

    async handleSendEmail() {
        await sendEmail({ records: this.selectedRecords, emailBody: this.emailDraft });
    }
}


