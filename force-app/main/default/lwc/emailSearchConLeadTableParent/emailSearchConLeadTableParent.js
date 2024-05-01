import { LightningElement } from 'lwc';

export default class EmailSearchConLeadTableParent extends LightningElement {

    email;

    handleEnteredEmail(event){

        this.email = event.detail.value;
        console.log('email -> ',this.email)
    }


    handleSearch(){

        this.template.querySelector('c-email-search-con-lead-table-child').searchConLead(this.email);
    }




}