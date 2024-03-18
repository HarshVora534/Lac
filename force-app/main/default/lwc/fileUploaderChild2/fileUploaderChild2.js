import { LightningElement } from 'lwc';

export default class fileUploaderChild2 extends LightningElement {
    fileNames = [];

    handleFileUpload(event) {
        this.fileNames = [];
        const files = event.target.files;
        for(let i = 0; i < files.length; i++) {
            this.fileNames.push(files[i].name);
            const fileSelectedEvent = new CustomEvent('fileselected', {
                detail: { file: files[i] },
            });
            this.dispatchEvent(fileSelectedEvent);
        }
    }
}
