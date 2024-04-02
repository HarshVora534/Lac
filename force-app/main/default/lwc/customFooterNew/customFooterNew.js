import { LightningElement,api } from 'lwc';
import {FlowNavigationNextEvent,FlowNavigationBackEvent,FlowNavigationFinishEvent} from 'lightning/flowSupport';

export default class CustomFooterNew extends LightningElement {
    @api showNext= false;
    @api showPrevious = false;
    @api showFinish = false;
    @api availableActions = [];

    get nextButton()
    {
        console.log(this.showNext);
        return this.showNext ? '' : 'slds-hide';
    }

    get PreviousButton()
    {
        console.log(this.showPrevious);
        return this.showPrevious ? '' : 'slds-hide';
    }

    get FinishButton()
    {
        console.log(this.showFinish);
        return this.showFinish ? '' : 'slds-hide';
    }

    handleNext()
    {
        if(this.availableActions.find((action)=> action === 'NEXT'))
        {
            const navigateNextEvent = new FlowNavigationNextEvent();
            this.dispatchEvent(navigateNextEvent);
        }
    }

    handlePrevious()
    {
        try 
        {
            if(this.availableActions.find((action)=> action === 'BACK'))
            {
                const navigateBackEvent = new FlowNavigationBackEvent();
                this.dispatchEvent(navigateBackEvent);
                console.log('success');
            }
        } 
        catch (error) 
        {
            console.log(error);
        }
    }

    handleFinish()
    {
        try{
            if(this.availableActions.find((action)=> action === 'FINISH'))
            {
                const navigateFinishEvent = new FlowNavigationFinishEvent();
                this.dispatchEvent(navigateFinishEvent);
            }
        }
        catch(e)
        {
            console.log(e);
        }
    }
}