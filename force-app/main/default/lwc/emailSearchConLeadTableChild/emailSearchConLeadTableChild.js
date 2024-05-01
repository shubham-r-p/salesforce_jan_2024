import { LightningElement , track , api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';  

import returnContacts from '@salesforce/apex/lwcControllerFour.returnContacts';
import returnLeads from '@salesforce/apex/lwcControllerFour.returnLeads';

const contactsCol = [
    {label:'Contact Name' , fieldName:'Name'},
    {label:'Email' , fieldName:'Email'},
    {label:'Mailing Address' , fieldName:'MailingAddress'},

    { type: "button", typeAttributes: {  
        label: 'View',  
        name: 'View'
    } }
]


export default class EmailSearchConLeadTableChild extends NavigationMixin(LightningElement) {

    showDatatablesCon = false;
    showDatatablesLead = false;

    conColumns = contactsCol;
    contactsData;
    @track lstLeads = new Array();

    @api searchConLead(emailSearch){

        console.log('inside child method')

        returnContacts({email : emailSearch})
        .then(con => {

            console.log('mail -> ',emailSearch,' con rec -> ',con)

            if(con.length > 0){

                this.contactsData = con;
                this.showDatatablesCon = true;

                this.dispatchEvent(new ShowToastEvent({
                    title : 'Success',
                    message : 'Contacts related to Email found successfully !',
                    variant : 'success'
                }))
            }else{
                this.showDatatablesCon = false;

                this.dispatchEvent(new ShowToastEvent({
                    title : 'Error',
                    message : 'No Contacts found related to entered Email !',
                    variant : 'error'
                }))
            }
        })
        .catch(err =>{

            this.showDatatablesCon = false;
        })



        returnLeads({email : emailSearch})
        .then(lead =>{

            console.log('mail -> ',emailSearch,' lead rec -> ',lead)

            if(lead.length > 0){

                for(let led of lead) {
                    let lead = Object.assign({}, led);
                    lead['URL'] = window.location.origin + '/lightning/r/Lead/' + led.Id + '/view';
                    this.lstLeads.push(lead);
                }

                this.showDatatablesLead = true;

                this.dispatchEvent(new ShowToastEvent({
                    title : 'Success',
                    message : 'Leads related to Email found successfully !',
                    variant : 'success'
                }))
            }else{
                this.showDatatablesCon = false;

                this.dispatchEvent(new ShowToastEvent({
                    title : 'Error',
                    message : 'No Leads found related to entered Email !',
                    variant : 'error'
                }))
            }
        })
        .catch(err =>{

            this.showDatatablesLead = false;
        })
}


handleRowAction(event){

    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: event.detail.row.Id,
            objectApiName: 'Account',
            actionName: 'view'
        },
    });

}








}