import { LightningElement , track } from 'lwc';
import getOpportunities from '@salesforce/apex/lwcControllerTwo.getOpportunities';

const column = [
    {label: 'Opp Name' , fieldName:'Name'},
    {label: 'Type' , fieldName:'Type'}
];

export default class SfNoobImperativeDemo extends LightningElement {

column = column;

@track data = new Array();

connectedCallback(){

    getOpportunities()
    .then(result => {

        this.data = result;
    })
    .catch(error => {

        console.log(error)
    })


}





















}