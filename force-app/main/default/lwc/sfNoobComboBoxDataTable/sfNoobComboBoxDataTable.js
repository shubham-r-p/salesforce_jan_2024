import { LightningElement , track ,api } from 'lwc';
import returnOpp from '@salesforce/apex/lwcControllerTwo.returnOpp'
import returnAllAcc from '@salesforce/apex/lwcControllerTwo.returnAllAcc';

const columns = [

    {label:'Opportunity Name' , fieldName:'Name'},
    {label:'Amount' , fieldName:'Amount'}
]


export default class SfNoobComboBoxDataTable extends LightningElement {

    value;

    @track columns = columns;

    @track cardVisibility = false;
    @track options;

    @track data;

    connectedCallback(){

        returnAllAcc()
        .then(responce => {

            let arr = [];

            for(var i=0;i<responce.length;i++){

                arr.push({label:responce[i].Name , value:responce[i].Id})
            }
                this.options = arr;
        })

    }



    handleChange(event){
    
        this.cardVisibility = true;

        let accId = event.detail.value;

        console.log(accId)

        returnOpp({accId : accId})
        .then(responce =>{

            this.data = responce;
        })
        .catch(error =>{

            window.alert('Error ==>'+error)
        })


    }





}