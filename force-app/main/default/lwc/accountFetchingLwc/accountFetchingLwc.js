// import { LightningElement, wire, track } from 'lwc';
// import getAllAcc from '@salesforce/apex/lwcAccountFetching.getAllAcc';

// export default class AccountFetchingLwc extends LightningElement {
//     @track selectedAccountId;
//     @track accountOptions = [];

//     @wire(getAllAcc)
//     wiredAccounts({ error, data }) {
//         if (data) {
//             this.accountOptions = data.map(account => ({
//                 label: account.Name,
//                 value: account.Id
//             }));
//             this.accountOptions.unshift({ label: 'Select an Account', value: '' });
//         } else if (error) {
//             console.error('Error retrieving accounts:', error);
//         }
//     }

//     handleChange(event) {
//         this.selectedAccountId = event.detail.value;
//     }
// }


import { LightningElement, wire, track } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_MESSAGE from '@salesforce/messageChannels/Account_Selected__c';
import getAllAcc from '@salesforce/apex/lwcAccountFetching.getAllAcc';

export default class AccountFetchingLwc extends LightningElement {
    @track selectedAccountId;
    @track accountOptions = [];

    @wire(MessageContext)
    messageContext;

    @wire(getAllAcc)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accountOptions = data.map(account => ({
                label: account.Name,
                value: account.Id
            }));
            this.accountOptions.unshift({ label: 'Select an Account', value: '' });
        } else if (error) {
            console.error('Error retrieving accounts:', error);
        }
    }

    handleChange(event) {
        this.selectedAccountId = event.detail.value;
        const message = {
            recordId: this.selectedAccountId
        };
        publish(this.messageContext, ACCOUNT_SELECTED_MESSAGE, message);
    }
}
