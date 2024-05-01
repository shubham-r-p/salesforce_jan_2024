import { LightningElement , track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi'

import allAccRec from '@salesforce/apex/lwcController.lstAllAccounts'
import deleteSelectedRows from '@salesforce/apex/lwcController.deleteAllRecords'
import returnContactsForSelectedAcc from '@salesforce/apex/lwcControllerTwo.returnContacts'

const actions = [

    { label:'View' , name:'view'},
    { label:'Edit' , name:'edit'},
    { label:'Delete' , name:'delete'}

]

export default class DataTableExIbirdsOrg extends NavigationMixin(LightningElement) {

    @track arrayAccounts;
    @track arrayContacts;

    @track isModalOpen = false;
    @track isModalOpenForMultipleAcc = false;


    actionName;
    rowRecord;

    selectedAccounts;

    @track accColumns = [

        { label:'Account Name' , fieldName : 'Name'},
        { label:'Account Number' , fieldName : 'AccountNumber'},
        { label:'Phone' , fieldName : 'Phone'},

        { type:'action', typeAttributes:{rowActions : actions} }
    ]
    
    @track contactColumns = [

        { label:'Contact Name' , fieldName : 'Name'},
        { label:'Email' , fieldName : 'Email'},
        { label:'Phone' , fieldName : 'Phone'},

        { type:'action', typeAttributes:{rowActions : actions} }
    ]

    handleAllSelectedRows(event){

        this.selectedAccounts = event.detail.selectedRows;
        console.log('All rows =>'+this.selectedAccounts)

        //collecting the ids of accouts in array
        let selectedAccIds = this.selectedAccounts.map(acc => acc.Id);

        // we will call imperative method

        returnContactsForSelectedAcc({ lstSobjectRecIds : selectedAccIds })
        .then(data => {
            this.arrayContacts = data;
            this.ShowToastMessage('Success',data.length+' Contacts related to selected accounts retrived successfully !', 'success');
        })
        .catch(error => {
            this.ShowToastMessage('Error', error.body.message, 'error');
        })
        
    }


    handleRowAction(event){

        this.actionName = event.detail.action.name;
        this.rowRecord = event.detail.row;

        //console.log('action name => '+actionName+' row => '+row.Name)


        if(this.actionName == 'view'){

            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.row.Id,
                    //objectApiName: 'Account',
                    actionName: 'view'
                },
            });

        }
        else if(this.actionName == 'edit'){

            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.row.Id,
                    //objectApiName: 'Account',
                    actionName: 'edit'
                },
            });

        }
        else{
                //this.deleteAccRecord(event.detail.row.Id);
                this.isModalOpen = true;
        }
    }


    deleteAccRecord(){

        let recordId = this.rowRecord.Id;

        deleteRecord(recordId)
        .then(() => {
            this.ShowToastMessage('Success','Record deleted successfully !','success');
            this.isModalOpen = false;
        })
        .catch(error => {
            this.ShowToastMessage('Error', error.body.message ,'error');
            this.isModalOpen = false;
        })
    }

    deleteSelectedAccModalOpen(){
        this.isModalOpenForMultipleAcc = true;
    }

    deleteSelectedAcc(){
        
        deleteSelectedRows({ lstSobjRec : this.selectedAccounts})
        .then(() => {
            this.ShowToastMessage('Success','All selected records deleted succesfully !','success');
            this.isModalOpen = false;
            this.isModalOpenForMultipleAcc = false;

        })
        .catch(error => {
            this.ShowToastMessage('Error', error.body.message ,'error');
            this.isModalOpen = false;
            this.isModalOpenForMultipleAcc = false;
        })
    }

    cancelTwo(){

        this.isModalOpenForMultipleAcc = false;
    }




    cancel(){

        this.isModalOpen = false;
    }


    ShowToastMessage(Title,Msg,Variant){

        this.dispatchEvent(new ShowToastEvent({

            title : Title,
            message: Msg,
            variant: Variant
        }))
    }


    @wire(allAccRec)
    wireHandler(result){

        if(result.data){
            this.arrayAccounts = result.data;
        }
    }




}