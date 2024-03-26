import { LightningElement, wire, api } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/messageChannelName__c'; // Replace with actual message channel name
import getRelatedContacts from '@salesforce/apex/lwcAccountFetching.getAllCon'; // Replace with actual Apex method
import getRelatedOpportunities from '@salesforce/apex/lwcAccountFetching.getAllOpp'; // Replace with actual Apex method

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
            msgService,
            (message) => {
                this.handleMessage(message);
            }
        );
    }

    handleMessage(message) {
        this.recordId = message.recordId;
        console.log(this.recordId);
        if (this.recordId) {
            this.loadRelatedData();
        }
    }

    async loadRelatedData() {
        try 
        {
            this.relatedContacts = await getRelatedContacts({ accountId : this.recordId });
            console.log(this.relatedContacts);
            this.relatedOpportunities = await getRelatedOpportunities({ accountId: this.recordId });
            console.log(this.relatedOpportunities);
        } 
        catch(error) {
            console.error('Error loading related data:', error);
        }
    }
}
