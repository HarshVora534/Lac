import { LightningElement, track } from 'lwc';
import searchRecords from '@salesforce/apex/SearchController.searchRecords';

 export default class ObjectSearch extends LightningElement {
        @track searchTerm = '';
        @track objectOptions = [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' }
        ];
        @track selectedObjects = [];
        @track searchResults;

        handleSearchTermChange(event) {
            this.searchTerm = event.target.value;
        }

        handleObjectSelection(event) {
            this.selectedObjects = event.detail.value;
        }

        handleSearch() {
            if (this.selectedObjects.length === 0) {
                return null;
            }

            searchRecords({ searchTerm: this.searchTerm, objectNames: this.selectedObjects })
                .then(result => {
                    this.searchResults = result;
                })
                .catch(error => {
                    console.log('Error Occured');
                });
        }
    }

