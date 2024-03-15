import { LightningElement,track } from 'lwc';

export default class FileUploaderParent extends LightningElement {
    @track fileUrl;
    handleFileSelected(event)
    {
        const file=event.detail.file;
        this.fileUrl = URL.createObjectURL(file);
    }
}