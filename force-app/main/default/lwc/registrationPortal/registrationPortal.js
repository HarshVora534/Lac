// import { LightningElement, track } from 'lwc';
// import registerUser from '@salesforce/apex/RegistrationController.registerUser';

// export default class RegistrationPortal extends LightningElement {
//     @track selectedUserType = '';
//     @track name = '';
//     @track email = '';
//     @track subjectTaught = '';
//     @track experience = '';
//     @track gradeLevel = '';
//     @track school = '';

//     get isTeacher() {
//         return this.selectedUserType === 'Teacher';
//     }

//     get isStudent() {
//         return this.selectedUserType === 'Student';
//     }

//     get userOptions() {
//         return [
//             { label: 'Teacher', value: 'Teacher' },
//             { label: 'Student', value: 'Student' }
//         ];
//     }

//     handleUserTypeChange(event) {
//         this.selectedUserType = event.detail.value;
//         console.log('hello'+this.selectedUserType);
//     }

//     handleInputChange(event) {
//         const { name, value } = event.target;
//         this[name] = value;
//     }

//     handleRegister() {
//         let userData = {
//             userType: this.selectedUserType,
//             name: this.name,
//             email: this.email,
//             subjectTaught: this.subjectTaught,
//             experience: this.experience,
//             gradeLevel: this.gradeLevel,
//             school: this.school
//         };

//         registerUser({ userData: userData })
//             .then(result => {
//                 // Handle success
//                 console.log('User registered successfully: ', result);
//             })
//             .catch(error => {
//                 // Handle error
//                 console.error('Error registering user: ', error);
//             });
//     }
// }
// registrationPortal.js
// import { LightningElement, track } from 'lwc';
// import registerUser from '@salesforce/apex/RegistrationController.registerUser';
// import name from '@salesforce/schema/Student__c.Name';
// import email from '@salesforce/schema/Student__c.email';
// import name from '@salesforce/schema/Teacher__c.Name';
// import email from '@salesforce/schema/Teacher__c.email';
// import subjectTaught from '@salesforce/schema/Teacher__c.subjectTaught';
// import experience from '@salesforce/schema/Teacher__c.experience';
// import gradeLevel from '@salesforce/schema/Student__c.gradeLevel';
// import school from '@salesforce/schema/Student__c.school';

// export default class RegistrationPortal extends LightningElement {
//     @track selectedUserType = '';
//     @track name = '';
//     @track email = '';
//     @track subjectTaught = '';
//     @track experience = '';
//     @track gradeLevel = '';
//     @track school = '';

//     // Getter functions for computed properties
//     get isTeacher() {
//         return this.selectedUserType === 'Teacher';
//     }

//     get isStudent() {
//         return this.selectedUserType === 'Student';
//     }

//     // Options for user type dropdown
//     get userOptions() {
//         return [
//             { label: 'Teacher', value: 'Teacher' },
//             { label: 'Student', value: 'Student' }
//         ];
//     }

//     // Handle change event for user type dropdown
//     handleUserTypeChange(event) {
//         this.selectedUserType = event.detail.value;
//         console.log('Selected User Type: ' + this.selectedUserType);
//     }

//     // Handle change event for input fields
//     handleInputChange(event) {
//         this.name=event.target.value;
//         this.email=event.target.value;
//         this.subjectTaught=event.target.value;
//         this.experience=event.target.value;
//         this.gradeLevel=event.target.value;
//         this.school=event.target.value;
//     }

//     // Handle register button click event
//     handleRegister() {
//         console.log('button clicked');
//         console.log(this.selectedUserType);
//         console.log(this.name);
//         console.log(this.email);
//         console.log(this.subjectTaught);
//         console.log(this.experience);
//         console.log(this.gradeLevel);
//         console.log(this.school);
//         // console.log(this.selectedUserType);
//         let userData = {
//             userType: this.selectedUserType,
//             name: this.name,
//             email: this.email,
//             subjectTaught: this.subjectTaught,
//             experience: this.experience,
//             gradeLevel: this.gradeLevel,
//             school: this.school
//         };

//         registerUser({ userData: userData })
//             .then(result => {
//                 // Handle success
//                 console.log('User registered successfully: ', result);
//             })
//             .catch(error => {
//                 // Handle error
//                 console.error('Error registering user: ', error);
//             });
//     }
// }




import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordCreationForm extends LightningElement {
    @track selectedRecordType = '';
    @track isStudent = false;
    @track isTeacher = false;

    options = [
        { label: 'Student', value: 'student' },
        { label: 'Teacher', value: 'teacher' },
    ];

    studentObjectApiName = 'Student__c';
    studentFields = ['Name', 'Email__c', 'Grade_Level__c', 'School__c'];

    teacherObjectApiName = 'Teacher__c';
    teacherFields = ['Name', 'Email__c', 'Subject_Taught__c', 'Experience__c'];

    handleChange(event) {
        this.selectedRecordType = event.detail.value;
        if (this.selectedRecordType === 'student') {
            this.isStudent = true;
            this.isTeacher = false;
        } else if (this.selectedRecordType === 'teacher') {
            this.isStudent = false;
            this.isTeacher = true;
        }
    }

    handleSubmit(event) {
        console.log(this.isStudent);
        console.log(this.isTeacher);
        const evt = new ShowToastEvent({
            title: 'Success Message',
            message: 'Record has been created',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}