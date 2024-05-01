import { LightningElement , api } from 'lwc';

export default class SfNoobChildComp extends LightningElement {


    @api myName = 'Shubham R Patil';


    @api handleValueChange(){

        this.myName = 'updated - Shubham R Patil';

    }



}