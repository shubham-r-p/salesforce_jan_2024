import { LightningElement , track , api} from 'lwc';

export default class QuickCalculatorChild extends LightningElement {

    @track displayResult;


    @api handleDispResult(event){


        console.log(event)
        this.displayResult = event;



    }




}