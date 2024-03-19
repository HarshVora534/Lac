import { LightningElement, wire } from 'lwc';
import fetchAllObjects from '@salesforce/apex/listOfObjects.fetchAllObjects';
import fetchAllFields from '@salesforce/apex/listOfObjects.fetchAllFields';
import fetchSearchResults from '@salesforce/apex/listOfObjects.fetchSearchResults';

export default class ObjectSearch2 extends LightningElement {
    objectOptions = [];
    selectedObjects = [];
    selectedFields = [];
    searchTerm = '';

    @wire(fetchAllObjects)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectOptions = Object.keys(data).map(key => ({ label: data[key], value: key }));
        } else {
            console.log('Error while fetching Objects');
        }
    }

    @wire(fetchAllFields)
    wiredFields({ error, data }) {
        if (data) {
            this.selectedFields = Object.entries(data).map(([objectName, fields]) => ({
                objectName,
                fields: fields.map(field => ({
                    fieldName: field.fieldName,
                    fieldLabel: field.fieldLabel
                }))
            }));
            console.log('-->',this.selectedFields);
        } else {
            console.log('Error while fetching Fields');
        }
    }

    handleObjectSelection(event) {
        this.selectedObjects = event.detail.value;
    }

    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        fetchSearchResults({ searchTerm: this.searchTerm, selectedObjectsString: JSON.stringify(this.selectedObjects) })
            .then(result => {
                console.log('Search Results:', result);
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
            });
    }
}
