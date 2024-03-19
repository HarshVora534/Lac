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
    wiredObjects({error,data})
    {
        if(data)
        {
            this.objectOptions = Object.keys(data).map(key=>({label :data[key] , value :key}));
        }
        else
        {
            console.log('Error WHile fetching Objects');
        }
    }

    @wire(fetchAllFields)
    wiredfeilds({error,data})
    {
        if(data)
        {
            this.selectedFields = data;
            console.log(this.selectedFields);
        }
        else
        {
            console.log('Error While fetching Feilds')
        }
    }

    handleObjectSelection(event)
    {
        this.selectedObjects=event.detail.value;
    }

    handleSearchTermChange(event) {
        this.searchTerm = event.target.value;
    }

    handleSearch() {
        const selectedFeildsString = JSON.stringify(this.selectedFields);
        console.log('-->',selectedFeildsString);
        fetchSearchResults({ searchTerm: this.searchTerm, selectedFeildsString })
            .then(result => {
                console.log('Search Results:', result);
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
            });
    }
}