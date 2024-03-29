// import { LightningElement, api } from 'lwc';
// import { FlowNavigationNextEvent } from 'lightning/flowSupport';

// export default class recordEditForm extends LightningElement {
//     @api objectApiName;
//     @api recordId;
//     @api fieldApiName;
//     @api availableActions = [];
    
//     formData = {};
//     value;

//     get fields() {
//         return this.fieldApiName.split(',');
//     }

//     handleFieldChange(event) {
//         this.formData[event.target.fieldName] = event.detail.value;
//     }

//     handleNext() {
//         const fields = this.template.querySelectorAll("lightning-input-field");
//         let recordData = {};
//         fields.forEach(field => {
//             recordData[field.fieldName] = field.value;
//         });
//         if (this.availableActions.find((action) => action === 'NEXT')) {
//             const navigateNextEvent = new FlowNavigationNextEvent(recordData);
//             this.dispatchEvent(navigateNextEvent);
//         }
//     }

//     handleSuccess(event) {
//         this.value = event.detail.id; 
//         console.log('Record Id:', this.value);
//     }
// }


import { LightningElement, api } from 'lwc';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';

export default class recordEditForm extends LightningElement {
    @api objectApiName;
    @api recordId;
    @api fieldApiName;
    @api availableActions = [];
    
    formData = {};

    get fields() {
        return this.fieldApiName.split(',');
    }

    get fieldValues() {
        let values = {};
        this.fields.forEach(field => {
            values[field] = this.formData[field] || '';
            console.log(values[field]);
        });
        console.log(values);
        return values;
    }

    handleFieldChange(event) {
        this.formData[event.target.fieldName] = event.detail.value;
    }

    handleNext() {
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

    handleSuccess(event) {
        this.recordId = event.detail.id; 
        console.log('Record Id:', this.recordId);
    }
}
