import { LightningElement, api, track } from 'lwc';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';

export default class recordEditForm extends LightningElement {
    @api objectApiName;
    @api recordId;
    @api fieldApiName;
    @api availableActions = [];
    
    @track isDisabled;
    formData = {};
    value;

    get fields() {
        return this.fieldApiName.split(',');
    }

    handleNext() {
        console.log('Success');
    }

    handleSuccess(event) {
        this.value = event.detail.id; 
        console.log('Record Id:', this.value);
        const fields = this.template.querySelectorAll("lightning-input-field");
        let recordData = {};
        fields.forEach(field => {
            recordData[field.fieldName] = field.value;
        });
        if (this.availableActions.find((action) => action === 'NEXT')) {
            const navigateNextEvent = new FlowNavigationNextEvent(recordData);
            this.dispatchEvent(navigateNextEvent);
        }
    }

    handleFieldChange(event) {
        this.formData[event.target.fieldName] = event.detail.value;
        this.checkFieldsFilled();
    }

    checkFieldsFilled() {
        const inputFields = this.template.querySelectorAll("lightning-input-field");
        let allFieldsFilled = true;
        inputFields.forEach(field => {
            if (!field.value) {
                allFieldsFilled = false;
            }
        });
        this.isDisabled = !allFieldsFilled;
    }

}