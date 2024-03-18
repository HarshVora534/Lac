import { LightningElement, wire, api } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import ACCOUNT_SELECTED_MESSAGE from '@salesforce/messageChannel/AccountSelected__c';
import getRelatedContacts from '@salesforce/apex/lwcAccountFetching.getAllCon';
import getRelatedOpportunities from '@salesforce/apex/lwcAccountFetching.getAllOpp';

export default class DisplayRelatedData extends LightningElement {
    @api recordId;
    @wire(MessageContext)
    messageContext;
    relatedContacts;
    relatedOpportunities;
        
    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            ACCOUNT_SELECTED_MESSAGE,
            (message) => {
                this.handleMessage(message);
            }
        );
    }

    handleMessage(message) {
        this.recordId = message.recordId;
        if (this.recordId) {
            this.loadRelatedData();
        }
    }

    loadRelatedData() {
        this.relatedContacts = getRelatedContacts({ accountId: this.recordId });
        this.relatedOpportunities = getRelatedOpportunities({ accountId: this.recordId });
    }
}
