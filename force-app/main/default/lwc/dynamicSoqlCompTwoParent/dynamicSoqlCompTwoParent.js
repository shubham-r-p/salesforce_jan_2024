import { LightningElement, wire , track } from 'lwc';
import returnObjects from '@salesforce/apex/dynamicSoqlCompTwoController.returnObjects';
import returnSobjectFields from '@salesforce/apex/dynamicSoqlCompTwoController.returnSobjectFields';
import returnRecords from '@salesforce/apex/dynamicSoqlCompTwoController.returnRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DynamicSoqlCompTwoParent extends LightningElement {

    noFieldSelected;
    isLoading = false;
    hideDatatable = false;
    allSobjects = [];
    selectedSobject;
    fieldValue = 'Id';
    showAllFields = false;
    allFieldsChkBox = [];
    @track allSelectedFields = [];
    @track recordsToDisplay ;

    connectedCallback(){

        returnObjects()
        .then((result) =>{
            let arr = []

            for(let x of result){
                arr.push({label : x.Name , value : x.API_Name__c})
            }

            this.allSobjects = arr;
        })
        .catch((err) => {
            console.log('Error --> ',err)
        })
    }


    handleComboboxChange(event){

        this.isLoading = true;

         this.hideDatatable = false;

         this.allSelectedFields = [];

         this.fieldValue = ["Id"];

        console.log('All sObjects --> ',JSON.stringify(this.allSobjects))

        this.selectedSobject = event.detail.value;   
        
        returnSobjectFields({sObj : this.selectedSobject})
        .then((result) =>{

            console.log('All Fields --> ',result)

            this.allFieldsChkBox = result; 

            this.isLoading = false;
        })
        .catch((err) => {

            console.log("Error --> ",err)
        })

        this.showAllFields = true;
    }


    handleCheckBoxes(event){

        this.hideDatatable = false;

        this.allSelectedFields = event.detail.value;

        console.log("Checked fields --> ",JSON.stringify(this.allSelectedFields));

        if(event.detail.value.length == 0){

            this.noFieldSelected = true;
        }
        else{
            this.noFieldSelected = false;
        }
    }

    handleButton(){

        if(this.noFieldSelected){

            this.dispatchEvent(new ShowToastEvent({

                title:'Error',
                message:'Please select atleast one field !',
                variant:'error'
        }))

        }
        else{
        
        this.isLoading = true;

        if(this.allSelectedFields.length == 0){

            this.allSelectedFields.push("Id");
        }
        let self = this;
        returnRecords({sObj : this.selectedSobject , selectedFields : this.allSelectedFields})
        .then((res) => {
            
            this.recordsToDisplay = res;
            
            this.hideDatatable = true; 

            setTimeout(() => {
                self.template.querySelector(".callChild").displayRecordsOnDataTable({ fields : self.allSelectedFields , records : self.recordsToDisplay , selectedObject : self.selectedSobject})

                this.isLoading = false;
            }, 500)

        })
        .catch((err) => {

            console.log("Error occured --> ",err)
        })

    }
    }

}