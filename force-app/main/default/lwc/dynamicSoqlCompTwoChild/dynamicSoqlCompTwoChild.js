import { LightningElement , api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

// export default class DynamicSoqlCompTwoChild extends LightningElement {
export default class DynamicSoqlCompTwoChild extends NavigationMixin (LightningElement) {


    @api recordsToDisplay = [];
    allSelectedFields;
    columnsList = [];
    showDataTable = false;
    selectedSobject;

    @api displayRecordsOnDataTable(event){

        console.log("In child comp --> ",JSON.stringify(event.fields));
        console.log("In child comp --> ",JSON.stringify(event.records));
        this.showDataTable = false;

        this.allSelectedFields = event.fields;
        this.columnsList = []

            for(let x of this.allSelectedFields){

                this.columnsList.push({label : x , fieldName : x});

                console.log("Field --> ",x)
            }

            this.columnsList.push({
                type: 'button',

                typeAttributes: { label: 'View', name: 'view' } , 
                
            })

        this.selectedSobject = event.selectedObject;

        this.recordsToDisplay = event.records;

        this.showDataTable = true;
    } 


    onrowactionAccount(event) {

        console.log('Object Name --> ',this.selectedSobject)
        console.log('rec id --> ',event.detail.row.Id)

        this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: event.detail.row.Id,
            objectApiName: this.selectedSobject,
            actionName: 'view'
        }
    });



}

}