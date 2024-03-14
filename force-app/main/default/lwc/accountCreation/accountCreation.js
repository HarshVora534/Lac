import { LightningElement, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
// import ACCOUNT_OBJECT from '@salesforce/schema/Account';
// import createAccount from '@salesforce/apex/createAcc.createAccount';
// import NAME_FEILD from '@salesforce/schema/Account.Name';
// import EMAIL_FEILD from '@salesforce/schema/Account.Email__c';
// import EXTRENALID_FEILD from '@salesforce/schema/Account.Externalid__c'
export default class AccountCreation extends LightningElement 
{
    @api recordId;
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
    // @track name=NAME_FEILD;
    // @track ExternalId=EXTRENALID_FEILD;
    // @track Email=EMAIL_FEILD;
    // rec={
    //     Name : this.name,
    //     Email : this.email,
    //     ExternalId : this.externalid
    // }
    // handleNameChange(event) {
    //     this.rec.Name = event.target.value;
    //     console.log("name1", this.rec.Name);
    // }
    
    // handleExternaidChange(event) {
    //     this.rec.ExternalId = event.target.value;
    //     console.log("Industry", this.rec.ExternalId);
    // }
    
    // handleEmailChange(event) {
    //     this.rec.Email = event.target.value;
    //     console.log("Phone", this.rec.Email);
    // }
    // handleClick() {
    //     createAccount({ acc : this.rec })
    //         .then(result => {
    //             this.message = result;
    //             this.error = undefined;
    //             if(this.message !== undefined) {
    //                 this.rec.Name = '';
    //                 this.rec.Industry = '';
    //                 this.rec.Phone = '';
    //                 this.dispatchEvent(
    //                     new ShowToastEvent({
    //                         title: 'Success',
    //                         message: 'Account created',
    //                         variant: 'success',
    //                     }),
    //                 );
    //             }
                
    //             console.log(JSON.stringify(result));
    //             console.log("result", this.message);
    //         })
    //     }

