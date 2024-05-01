import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SalesforceNoobFirstComp extends LightningElement {

    myName = 'Shubham R Patil'


 /*    connectedCallback(){

        let result = this.myFunction(49 , 7);
        window.alert('result  => '+result)

    } */

    myFunction(diviident , divisor){

        return(diviident/divisor);
    }


    handleClick(){

       // window.alert('Shubham Patil');


       this.showToastMessage('demo ShowToastMessage',this.myName,'warning')

    }


    showToastMessage(title,msg,variant){

        let newShowToastMsg = new ShowToastEvent({

            title : title,
            Message : msg, 
            variant: variant
        })

         this.dispatchEvent(newShowToastMsg)
            
            /*new ShowToastEvent({

                title : title,
                Message : msg, 
                variant : variant
            })) */

        
        }

}