import { LightningElement , wire } from 'lwc';
import { publish,MessageContext } from 'lightning/messageService';
import MyFirstChannel from '@salesforce/messageChannel/MyFirstChannel__c';
import returnAllAcc from '@salesforce/apex/lwcController3.returnAllAcc';


export default class FirstPublishComponent extends LightningElement {

    value;

    allOptions = [];

    @wire(MessageContext)
    messageContext;

    get options() {
        return this.allOptions
    }
    

    connectedCallback(){

        returnAllAcc()
        .then(result=>{

            let arr = new Array();
            
            for(var i=0;i<result.length;i++){

                arr.push({label:result[i].Name , value:result[i].Id})
            }

            this.allOptions = arr;

        })
}


    handlePlusOne(){

        const payload = {
            operator:'add',
            number:1
        }

        publish(this.messageContext , MyFirstChannel , payload);
    }


    handleMinusOne(){

        const payload = {
            operator:'sub',
            number:1
        }

        publish(this.messageContext , MyFirstChannel , payload);
    }

    handleMultiplication(){

        const payload = {
            operator:'mul',
            number:2
        }

        publish(this.messageContext , MyFirstChannel , payload);
    }

    handleComboboxChange(event){

        const payload = {
            operator:'id',
            number:event.detail.value
        }

        console.log('acc id sent via lms-->',payload)

        publish(this.messageContext , MyFirstChannel , payload);


    }

}