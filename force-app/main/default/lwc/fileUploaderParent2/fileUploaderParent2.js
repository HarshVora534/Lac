import { LightningElement } from 'lwc';

export default class fileUploaderParent2 extends LightningElement {
    previewImage;

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            const imageUrl = uploadedFiles[0].documentId;
            this.previewImage = `/services/preview/${imageUrl}`;
        }
    }
}
