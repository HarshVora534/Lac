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
        } else if (error) {
            console.error('Error fetching object list', error);
        }
    }

    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }

    handleObjectSelection(event) {
        this.selectedObjects = event.detail.value;
    }

    async handleSearch() {
        try {
            const selectedObjectsString = JSON.stringify(this.selectedObjects);
            const result = await fetchSearchResults({ searchTerm: this.searchTerm, selectedObjectsString });
            this.searchResults = result;
        } catch (error) {
            console.error('Error searching:', error);
        }
    }
}
