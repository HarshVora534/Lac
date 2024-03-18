// // fileUploader.js
// import { LightningElement, track } from 'lwc';

// const PAGE_SIZE = 5;

// export default class FileUploaderPagination extends LightningElement {
//     @track files = [];
//     @track uploadedFiles = []; // Store uploaded files
//     @track pageNumber = 1;

//     // Columns for the datatable
//     columns = [
//         { label: 'File Name', fieldName: 'Name' },
//         { label: 'File Size', fieldName: 'Size' },
//     ];

//     // Handle file change event
//     handleFileChange(event) {
//         this.files = event.target.files;
//     }

//     // Handle file upload
//     handleUpload() {
//         // Implement upload logic
//         // After uploading, populate this.uploadedFiles with data for each file
//         this.files.forEach(file => {
//             this.uploadedFiles.push({
//                 Id: this.uploadedFiles.length + 1, // Generate unique ID for each file
//                 Name: file.name,
//                 Size: file.size
//             });
//         });
//     }

//     // Paginate data
//     get pagedData() {
//         const startIndex = (this.pageNumber - 1) * PAGE_SIZE;
//         const endIndex = startIndex + PAGE_SIZE;
//         return this.uploadedFiles.slice(startIndex, endIndex);
//     }

//     // Calculate if previous button should be disabled
//     get disablePrevious() {
//         return this.pageNumber <= 1;
//     }

//     // Calculate if next button should be disabled
//     get disableNext() {
//         return this.pageNumber >= Math.ceil(this.uploadedFiles.length / PAGE_SIZE);
//     }

//     // Handle next page navigation
//     handleNext() {
//         if (!this.disableNext) {
//             this.pageNumber++;
//         }
//     }

//     // Handle previous page navigation
//     handlePrevious() {
//         if (!this.disablePrevious) {
//             this.pageNumber--;
//         }
//     }
// }

import { LightningElement, track } from 'lwc';

export default class FileUploaderPagination extends LightningElement {
    @track fileNames = [];
    pageSize = 3;
    pageNumber = 1;

    handleFileUpload(event) {
        this.fileNames = [];
        const files = event.target.files;
        for(let i = 0; i < files.length; i++) {
            this.fileNames.push(files[i].name);
        }
        this.pageNumber = 1; // Reset page number when files are uploaded
    }

    get pagedFileNames() {
        const start = (this.pageNumber - 1) * this.pageSize;
        const end = this.pageNumber * this.pageSize;
        return this.fileNames.slice(start, end);
    }

    get showPagination() {
        return this.fileNames.length > this.pageSize;
    }

    get disablePrevious() {
        return this.pageNumber === 1;
    }

    get disableNext() {
        return this.pageNumber === Math.ceil(this.fileNames.length / this.pageSize);
    }

    previousPage() {
        if (!this.disablePrevious) {
            this.pageNumber--;
        }
    }

    nextPage() {
        if (!this.disableNext) {
            this.pageNumber++;
        }
    }
}
