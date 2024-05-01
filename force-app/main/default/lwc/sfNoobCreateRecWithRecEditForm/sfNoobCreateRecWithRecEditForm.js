import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import contactObjApi from '@salesforce/schema/Contact';
import fNameApi from '@salesforce/schema/Contact.FirstName'
import lNameApi from '@salesforce/schema/Contact.LastName'
import phoneApi from '@salesforce/schema/Contact.Email'
import emailApi from '@salesforce/schema/Contact.Phone'

export default class SfNoobCreateRecWithRecEditForm extends LightningElement {

contactObjApi = contactObjApi;
fNameApi = fNameApi;
lNameApi = lNameApi;
phoneApi = phoneApi;
emailApi = emailApi;

@track genId = 'Record Id will show here...'


handleSuccess(event){

    this.genId = event.detail.id;
    console.log(event.detail.id);

    this.dispatchEvent(new ShowToastEvent({

        title:'Success',
        message:'Contact successfully created with Id '+event.detail.id,
        variant:'warning'
    }))
}











}