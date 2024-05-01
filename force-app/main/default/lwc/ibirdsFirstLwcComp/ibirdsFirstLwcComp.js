import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class IbirdsFirstLwcComp extends LightningElement {

    firstName;
    lastName;


    onchangeEvent(event){

        let name = event.currentTarget.name;

        if(name == 'fn' ){

            this.firstName = event.currentTarget.value;
        }
        else{
            this.lastName = event.currentTarget.value;
        }
    }


    showDetails() {

        let toastEvent = new ShowToastEvent({
            title: 'Toast Message LWC',
            message: this.firstName + ' ' + this.lastName,
            variant: 'warning'
        })

        this.dispatchEvent(toastEvent);
    }








}