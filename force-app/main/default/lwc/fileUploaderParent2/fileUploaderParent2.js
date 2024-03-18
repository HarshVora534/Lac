import { LightningElement, track } from 'lwc';

export default class FileUploaderParent2 extends LightningElement {
    @track fileUrls = [];

    handleFileSelected(event) {
        const file = event.detail.file;
        this.fileUrls.push(URL.createObjectURL(file));
    }
}
