import { LightningElement , api , track , wire } from 'lwc';
import returnAllAcc from '@salesforce/apex/lwcController3.returnAllAcc'

export default class AccComboboxConDatatableParent extends LightningElement {

    value;

    @track allOptions;

    @track accId;

    connectedCallback(){

        returnAllAcc()
        .then(responce=>{

            let arr = new Array();

            for(var i=0;i<responce.length;i++){

                arr.push({label:responce[i].Name , value:responce[i].Id})
            }

                this.allOptions = arr;
        })
    }


    handleOnChange(event){



        console.log('event.detail.value --> ',event.detail.value);
        console.log('event.target.value --> ',event.target.value);

        this.value = event.detail.value;

        this.accId = event.detail.value;

        console.log('accId -> '+this.accId)

        this.template.querySelector('c-acc-combobox-con-datatable-child').loadDataTable(this.value);
    }




}