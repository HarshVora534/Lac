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
            console.log('data ',data);
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
                console.log(this.searchResults);
            })
            .catch(error => {
                console.error('Error fetching search results:', error);
            });
    }
    get firstObject()
    {
        return this.selectedObjects[0];
    }
    get secondObject()
    {
        return this.selectedObjects[1];
    }
    get thirdObject()
    {
        return this.selectedObjects[2];
    }
    get firstSearchTerm() {
        if (this.searchResults.length > 0) {
            console.log('--->',this.searchResults[0]);
            return this.searchResults[0]; 
        } else {
            return ''; 
        }
    }    
    get secondSearchTerm() {
        if (this.searchResults.length > 0) {
            console.log('--->',this.searchResults[1]);
            return this.searchResults[1]; 
        } else {
            return ''; 
        }
    }  
    get thirdSearchTerm() {
        if (this.searchResults.length > 0) {
            console.log('--->',this.searchResults[2]);
            return this.searchResults[2]; 
        } else {
            return ''; 
        }
    }  
}

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
//             console.log('data ',data);
//             this.objectOptions = Object.keys(data).map(key => ({ label: data[key], value: key }));
//         } else {
//             console.error('Error while fetching Objects', error);
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
//                 this.searchResults = result;
//                 console.log(this.searchResults);
//             })
//             .catch(error => {
//                 console.error('Error fetching search results:', error);
//             });
//     }
// }
