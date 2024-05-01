import { LightningElement , api , track , wire } from 'lwc';

export default class QuickCaseSearchParentt extends LightningElement {

    @api caseNumber;

    handleCaseNoChange(event){

            this.caseNumber = event.target.value;
            console.log(this.caseNumber);
    }


    handleSearch(){

        this.template.querySelector('c-quick-case-search-childd').returnCase(this.caseNumber);


    }
}