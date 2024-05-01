import { LightningElement , api , track , wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import returnRelatedContacts from '@salesforce/apex/lwcControllerTwo.returnRelatedContacts'

const rowAct = [

    {label:'View' , name:'view'},
    {label:'Edit' , name:'Edit'},
    {label:'Delete' , name:'delete'}
]

const columns = [

    {label:'Contact Name' , fieldName:'Name'},
    {label:'Email' , fieldName:'Email'},
    {
        type:'action',
        typeAttributes:{ rowActions :  rowAct}
    }

]


export default class SfNoobDatatableWithSearch extends NavigationMixin (LightningElement) {

    columns = columns;

@api recordId;

actionName;
selectedRecord;
@track buttonName = 'Show';
@track data = new Array();
@track tableVisibility = false;

connectedCallback(){

    returnRelatedContacts({ accountId : this.recordId})
    .then(responce => {

        this.data = responce;
    })
    .catch(error=>{

        console.log('Error==>'+error)
    })
}

handleButtonClick(event){

    let buttonLabel = event.target.label;

    if(buttonLabel == 'Show'){

        this.tableVisibility = true;
        this.buttonName = 'Hide';
    }
    else if(buttonLabel == 'Hide'){

        this.tableVisibility = false;
        this.buttonName = 'Show';
    }
}


getSelectedRows(event){

    let selRowa = event.detail.selectedRows;

    window.alert(JSON.stringify(selRowa))

    this.dispatchEvent(new ShowToastEvent({

        title:'Records --> ',
        message:JSON.stringify(selRowa),
        variant: 'success'
    }))
}

handleRowActions(event){

    this.actionName = event.detail.action.name;
    this.selectedRecord = {...event.detail.row};

    console.log(this.actionName)
    console.log(event.detail.row.Id)


    if(this.actionName == 'view'){

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.selectedRecord.Id,
                actionName: 'view'
            }
        })
    }
    else if(this.actionName == 'edit'){

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.row.Id,
                objectApiName: 'Contact',
                actionName: 'edit'
            },
        });
    }
    else if(this.actionName == 'delete'){

        let recordId = this.selectedRecord.Id;

        deleteRecord(recordId)
        .then(() => {
            this.dispatchEvent(new ShowToastEvent({

                title:'Success',
                message:'Record deleted Successfully !',
                variant:'success'
        }))
        })
        .catch(error=>{

            console.log(error)
        })
    }
}

handleSearchChange(event){

    let searchKey = event.detail.value;

    returnRelatedContacts({ accountId : this.recordId , key : searchKey})
    .then(responce =>{

        this.data = responce;
    })
    .catch(error =>{

        console.log(error)
    })


}






}