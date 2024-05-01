import { LightningElement , api , track , wire } from 'lwc';
import returnRelContacts from '@salesforce/apex/lwcController3.returnRelContacts'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [

    { label:'Name' , fieldName:'Name'},
    { label:'Email' , fieldName:'Email'},
    { label:'Phone' , fieldName:'Phone'}
]

export default class AccComboboxConDatatableChild extends LightningElement {

    @api tableVisible = false;

    @track allColumns = columns;

    @track allData;

    @api accRecordId;

    @api loadDataTable(event){

        console.log('event->',event)

        console.log('accountId -> ',this.accRecordId)

        returnRelContacts({accId : event})
        .then(result=>{

            console.log(result);

            this.tableVisible = true;

            this.allData = result;

            this.dispatchEvent(new ShowToastEvent({

                title:'Success',
                message:'Contacts fetched successfully !',
                variant:'success'
            }))
        })
        .catch(error=>{

            console.log(error)
        })


    
    }

}