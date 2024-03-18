import { LightningElement, track } from 'lwc';

export default class fileUploader extends LightningElement {
    @track files = [];
    @track displayedFiles = [];
    @track currentPage = 1;
    pageSize = 5; // Change the number of items per page as required

    // Columns for the datatable
    columns = [
        { label: 'File Name', fieldName: 'Name' },
        { label: 'Type', fieldName: 'Type' },
        { label: 'Size (Bytes)', fieldName: 'Size' }
    ];

    get totalFiles() {
        return this.files.length;
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        this.files.push({
            Id: this.files.length + 1,
            Name: file.name,
            Type: file.type,
            Size: file.size
        });
        this.updateDisplayedFiles();
    }

    updateDisplayedFiles() {
        const startIndex = (this.currentPage - 1) * this.pageSize;
        const endIndex = this.currentPage * this.pageSize;
        this.displayedFiles = this.files.slice(startIndex, endIndex);
    }

    handlePageChange(event) {
        this.currentPage = event.detail.page;
        this.updateDisplayedFiles();
    }
}
