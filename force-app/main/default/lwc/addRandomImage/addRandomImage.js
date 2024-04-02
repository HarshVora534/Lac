// import { LightningElement } from 'lwc';

// export default class AddRandomImage extends LightningElement {

//     addRandomImage()
//     {
//         getRandomImage()
//         .then(result=>{
//             this.image=result;
//         })
//         .catch(error=>
//         {
            
//         })
//     }

// }
// import { LightningElement, api } from 'lwc';
// import addRandomImage from '@salesforce/apex/RandomImageGenerator.addRandomImage';

// export default class AddRandomImage extends LightningElement {
//     @api recordId;
//     imageURL;

//     addRandomImage() {
//         addRandomImage({ opportunityId: this.recordId })
//             .then(result => {
//                 this.imageURL = result;
//                 console.log('Image URL:', this.imageURL);
//                 console.log('Image added successfully');
//             })
//             .catch(error => {
//                 console.error('Error adding image:', error);
//             });
//     }
// }


import { LightningElement } from 'lwc';
import addRandomImage from '@salesforce/apex/RandomImageGenerator.addRandomImage';

export default class AddRandomImage extends LightningElement {
    imageURL;

    connectedCallback() {
        this.fetchRandomImage();
    }

    fetchRandomImage() {
        addRandomImage()
            .then(result => {
                this.imageURL = result;
                console.log('Image URL:', this.imageURL);
            })
            .catch(error => {
                console.error('Error fetching image:', error);
            });
    }
}



