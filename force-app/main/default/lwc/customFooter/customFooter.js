import { LightningElement, track } from 'lwc';

export default class MultiStepComponent extends LightningElement {
    currentStep = 1;
    @track firstStep = '';
    @track secondStep = '';
    @track thirdStep = '';
    @track secondDisable = '';
    @track isFinishDisabled = '';

    get isFirstStep() {
        return this.currentStep === 1;
    }

    get isSecondStep() {
        return this.currentStep === 2;
    }

    get isThirdStep() {
        return this.currentStep === 3;
    }

    get isNextDisabled() {
        return !this.firstStep.trim(); // Disable next button if firstStep value is null or blank
    }

    get isPreviousDisabled() {
        return this.currentStep === 1;
    }

    get isFinishDisabled() {
        return this.currentStep !== 3;
    }

    nextStep() {
        if (this.currentStep < 3) {
            this.currentStep++;
        }
    }

    previousStep() {
        if (this.currentStep > 1) {
            this.currentStep--;
        }
    }

    handleFirstInputChange(event) {
        this.firstStep = event.target.value;
        if (!this.firstStep) {
            console.log('Input value: null or blank');
        } else {
            console.log('Input value:', this.firstStep);
        }
    }

    handleSecondInputChange(event) {
        this.secondStep = event.target.value;
        console.log(this.secondStep);
        this.secondDisable=true;
        if (!this.secondStep) {
            console.log('Input value: null or blank');
            this.secondDisable = true; 
        } else {
            console.log('Input value:', this.secondStep);
            this.secondDisable = false; 
        }
    }

    handleThirdInputChange(event) {
        this.thirdStep = event.target.value;
        console.log(this.secondStep);
        this.isFinishDisabled=true;
        if (!this.thirdStep) {
            console.log('Input value: null or blank');
            this.isFinishDisabled = true;
        } else {
            console.log('Input value:', this.thirdStep);
            this.isFinishDisabled = false;
        }
    }
    

    finish() {
        console.log('Process finished.');
    }
}


