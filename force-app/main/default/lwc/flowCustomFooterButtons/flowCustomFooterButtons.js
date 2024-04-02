import { LightningElement, api } from 'lwc';
import { FlowNavigationNextEvent, FlowNavigationBackEvent, FlowNavigationFinishEvent } from 'lightning/flowSupport';

export default class flowCustomFooterButtons extends LightningElement {
    @api showPrevious = false;
    @api showNext = false;
    @api showSave = false;
    @api disablePrevious = false;
    @api disableNext = false;
    @api disableSave = false;
    @api availableActions = [];
    @api text='';

    get previousButtonClass() {
        return this.showPrevious ? '' : 'slds-hide';
    }

    get nextButtonClass() {
        return this.showNext ? '' : 'slds-hide';
    }

    get saveButtonClass() {
        return this.showSave ? '' : 'slds-hide';
    }

    handlePrevious() {
        if (!this.disablePrevious) {
            if (this.availableActions.find((action) => action === 'BACK')) {
                const navigateBackEvent = new FlowNavigationBackEvent();
                this.dispatchEvent(navigateBackEvent);
            }
        }
    }

    handleNext() {
        // console.log(text);
        if (!this.disableNext) {
            if (this.availableActions.find((action) => action === 'NEXT')) {
                const navigateNextEvent = new FlowNavigationNextEvent();
                this.dispatchEvent(navigateNextEvent);
            }
        }
    }

    handleSave() {
        if (!this.disableSave) {
            if (this.availableActions.find((action) => action === 'Finish')) {
                const navigateFinishEvent = new FlowNavigationFinishEvent();
                this.dispatchEvent(navigateFinishEvent);
            }
        }
    }
}
