// import { LightningElement, wire } from 'lwc';
// import fetchAllObjects from '@salesforce/apex/listOfObjects.fetchAllObjects';
// import fetchSearchResults from '@salesforce/apex/listOfObjects.fetchSearchResults';

// export default class ObjectSearch2 extends LightningElement {
//     objectOptions = [];
//     selectedObjects = [];
//     searchTerm = '';
//     searchResults = [];

//     @wire(fetchAllObjects)
//     wiredObjects({ error, data }) {
//         if (data) {
//             this.objectOptions = Object.keys(data).map(key => ({ label: data[key], value: key }));
//         } else {
//             console.log('Error while fetching Objects');
//         }
//     }

//     handleObjectSelection(event) {
//         this.selectedObjects = event.detail.value;
//     }

//     handleSearchTermChange(event) {
//         this.searchTerm = event.target.value;
//     }

//     handleSearch() {
//         fetchSearchResults({ searchTerm: this.searchTerm, selectedObjectsString: JSON.stringify(this.selectedObjects) })
//             .then(result => {
//                 console.log('Search Results:', result);
//                 this.searchResults = result.map(objResult => ({
//                     objectName: objResult.objectName,
//                     records: objResult.records
//                 }));
//             })
//             .catch(error => {
//                 console.error('Error fetching search results:', error);
//             });
//     }
// }

import { LightningElement, wire } from 'lwc';
import fetchAllObjects from '@salesforce/apex/listOfObjects.fetchAllObjects';
import fetchSearchResults from '@salesforce/apex/listOfObjects.fetchSearchResults';

export default class ObjectSearch2 extends LightningElement {
    objectOptions = [];
    selectedObjects = [];
    searchTerm = '';
    searchResults = [];

    @wire(fetchAllObjects)
    wiredObjects({ error, data }) {
        if (data) {
            this.objectOptions = Object.keys(data).map(key => ({ label: data[key], value: key }));
        } else {
            console.error('Error while fetching Objects', error);
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
                this.searchResults = result;
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
            });
    }    
    
}
