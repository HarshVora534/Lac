import { LightningElement } from 'lwc';

export default class SendEmailIntegration extends LightningElement {
    acceptedFormats = ['.pdf', '.png', '.jpg', '.jpeg'];
    modalVisible=false;
    handleSubmit()
    {
        this.modalVisible=true;
    }
    handleSend()
    {
        this.modalVisible=false;
    }
}