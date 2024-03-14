import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName'
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName'
import PHONE_FEILD from '@salesforce/schema/Contact.Phone'
export default class ContactCreationLWC extends LightningElement {
    
    objectApiName= CONTACT_OBJECT;
    fields=[FIRSTNAME_FIELD,LASTNAME_FIELD,PHONE_FEILD];
    handleSubmit(event){
        const evt= new ShowToastEvent({
            title:'Success Msg',
            message:'Record has been created',
            variant:'success',
            mode:'dismissible'
        })
        this.dispatchEvent(evt);
    }
}