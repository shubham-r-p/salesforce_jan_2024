import { LightningElement , api } from 'lwc';

export default class SfNoobParToChildDemoChild extends LightningElement {

    @api inputVal;

    @api additionHandler(event){

        console.log('inside handler',event)

        this.inputVal = parseInt(this.inputVal) + event;
    }

    @api resetInput(){

        thhis.inputVal = '';
    }

}