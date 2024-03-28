import { LightningElement } from 'lwc';

export default class AddRandomImage extends LightningElement {

    addRandomImage()
    {
        getRandomImage()
        .then(result=>{
            this.image=result;
        })
        .catch(error=>
        {
            
        })
    }

}