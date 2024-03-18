import { LightningElement, wire } from 'lwc';
import fetchAllObjects from '@salesforce/apex/listOfObjects.fetchAllObjects';

export default class ObjectSearch extends LightningElement {
    searchTerm = '';
    selectedObjects = [];
    objectOptions = [];
    searchResults = [];

    @wire(fetchAllObjects)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectOptions = Object.keys(data).map(key => ({ label: data[key], value: key }));
        } else {
            console.error('Error fetching object list');
        }
    }

    handleSearchTermChange(event) {
        this.searchTerm = event.detail.value;
        console.log('-->',this.searchTerm);
    }

    handleObjectSelection(event) {
        this.selectedObjects = event.detail.value;
        this.searchTerm = this.selectedObjects.join(',');
    }

    async handleSearch() {
        try {
            const selectedObjectsString = JSON.stringify(this.selectedObjects);
            console.log(selectedObjectsString);
            const result = await fetchSearchResults({ searchTerm: this.searchTerm, selectedObjectsString });
            console.log('-->',result);
            this.searchResults = result;
        } catch (error) {
            console.error('Error searching:', error);
        }
    }
}
