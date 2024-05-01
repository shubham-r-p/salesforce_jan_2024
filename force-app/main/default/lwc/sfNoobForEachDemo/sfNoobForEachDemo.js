import { LightningElement , wire , track } from 'lwc';
import returnCases from '@salesforce/apex/lwcControllerTwo.returnCases'

export default class SfNoobForEachDemo extends LightningElement {

    @track arrayCases = new Array();

    @wire(returnCases)
    wireHandler(result){

        if(result.data){

            this.arrayCases = result;
        }
    }




    
}