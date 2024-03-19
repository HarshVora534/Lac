import { LightningElement ,track} from 'lwc';
import getObjectRecords from '@salesforce/apex/WizardController.getObjectRecords';
import sendEmail from '@salesforce/apex/WizardController.sendEmail';
import draftEmail from '@salesforce/apex/WizardController.draftEmail';

export default class LwcWizard extends LightningElement {
    @track OneVisible = true;
    @track twoVisible = false;
    @track threeVisible = false;
    @track objectOptions = [{ label: 'Lead', value: 'Lead' }, { label: 'Account', value: 'Account' }, { label: 'Contact', value: 'Contact' }];
    @track selectedObject;
    @track objectRecords;
    @track selectedRecords = [];
    @track emailDraft;
    @track disablePrevious = true;

    columns = [
        {label: 'Name', fieldName: 'Name'},
        {label: 'Email', fieldName: 'Email', type:'email'}
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
    handleNext()
    {
        if(this.OneVisible)
        {
            this.OneVisible=false;
            this.twoVisible=true;
        }
        else if(this.twoVisible)
        {
            this.twoVisible=false;
            this.threeVisible=true;
        }
        this.disablePrevious=false;
    }
    handlePrevious()
    {
        if(this.twoVisible)
        {
            this.twoVisible=false;
            this.OneVisible=true;
        }
        else if(this.threeVisible)
        {
            this.threeVisible=false;
            this.twoVisible=true;
        }
        if(!this.twoVisible)
        {
            this.disablePrevious=true;
        }
    }
    handleEmailDraft(event)
    {
        this.emailDraft=event.detail.value;
    }
    async handleSendEmail(event)
    {
        await SendEmail({records:this.selectedRecords,emailbody: this.emailDraft});
    }
}