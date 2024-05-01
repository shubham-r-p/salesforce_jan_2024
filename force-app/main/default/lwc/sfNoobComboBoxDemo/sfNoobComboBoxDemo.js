import { LightningElement , track } from 'lwc';
import returnAllAcc from '@salesforce/apex/lwcControllerTwo.returnAllAcc';


export default class SfNoobComboBoxDemo extends LightningElement {

    @track value = '';
    @track data;


    connectedCallback(){

        returnAllAcc()
        .then(responce =>{

            let arr = [];

            for(var i=0 ; i<responce.length;i++){
                arr.push({label : responce[i].Name , value : responce[i].Id })
            }

            this.data = arr;
        })


    }


    get optionValues(){
        return this.data;
    }


    
    handleBoxChange(event){

        this.value = event.detail.value;

    }



}