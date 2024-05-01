import { LightningElement , track , api, wire} from 'lwc';
import returnContacts from '@salesforce/apex/lwcControllerTwo.lstAllContacts'

const columns = [

    {label:'Name' , fieldName:'Name'},
    {label:'Email' , fieldName:'Email'},
    {label:'Phone' , fieldName:'Phone'}
];

export default class SfNoobWireDemo extends LightningElement {

     columns = columns;

    @track arrayData = new Array();


    @wire(returnContacts)
    wireHandler(result){

        console.log(result);

        if(result.data){

            console.log(result.data)

            this.arrayData = result.data;
        }
        else if(result.error){

            console.log(result.error)
        }

    }





}