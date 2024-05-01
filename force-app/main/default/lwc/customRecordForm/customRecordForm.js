import { LightningElement } from 'lwc';
import lwcControllerCreateClass from '@salesforce/apex/lwcController.createContacts';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class CustomRecordForm extends LightningElement {


    record = {}

    handleFieldValue(event){
        let apiName = event.detail.apiName;
        let value = event.detail.value;

        console.log(value);

        this.record[apiName] = value;
    }


    createContact(){
        console.log(this.record);


        lwcControllerCreateClass({objCon : this.record})
        .then(result=>{


            this.dispatchEvent(new ShowToastEvent({

                title : 'Success',
                message: 'Record created successfully with Id => '+result,
                variant: 'success'

            }));
        })
        .catch(error=>{

            console.log(error);
        })


    }




}