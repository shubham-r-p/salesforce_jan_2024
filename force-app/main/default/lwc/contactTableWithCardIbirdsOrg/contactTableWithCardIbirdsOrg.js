import { LightningElement , track , wire } from 'lwc';

import lstContacts from '@salesforce/apex/lwcController.returnContacts';

export default class ContactTableWithCardIbirdsOrg extends LightningElement {

    @track arrayContacts = new Array();
    @track title;
    @track error;


    @wire(lstContacts)
    wiredContactHandler(result){

        if(result){

            if(result.data){

                for(let con of result.data){

                    let contact = Object.assign({} , con);

                    contact['URL'] = window.location.origin+'/lightning/r/Contact/'+con.Id+'/view';

                    this.arrayContacts.push(contact);

                    //this.arrayContacts = result.data;
                    this.title = 'All Contacts ('+result.data.length+')';
                }
            }
            else{
                this.error = result.error;
            }
        }
    }

}