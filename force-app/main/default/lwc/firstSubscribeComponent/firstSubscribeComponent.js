import { LightningElement, track, wire } from 'lwc';
import { subscribe,MessageContext } from 'lightning/messageService';
import MyFirstChannel from '@salesforce/messageChannel/MyFirstChannel__c';

export default class FirstSubscribeComponent extends LightningElement {

    @track counter = 0;
    subscription = null;
    shoeRecViewForm = false;

    recordId;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel(){

        this.subscription = subscribe(

            this.messageContext,
            MyFirstChannel,
            (result) => this.handleLms(result)
        )
    }


    handleLms(result){

        console.log('result --> ',result)

        if(result.operator == 'add'){

            this.counter = this.counter + parseInt(result.number);
        }
        else if(result.operator == 'sub'){

            this.counter = this.counter - parseInt(result.number);
        }
        else if(result.operator == 'id'){
            this.recordId = result.number;
            this.shoeRecViewForm = true;
        }
        else{
            this.counter = this.counter * parseInt(result.number);
        }
    }


}