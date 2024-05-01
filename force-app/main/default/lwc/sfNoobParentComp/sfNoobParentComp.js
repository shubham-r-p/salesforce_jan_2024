import { LightningElement } from 'lwc';

export default class SfNoobParentComp extends LightningElement {

    newName = 'sp';

    callChildFun(){


        this.template.querySelector('c-sf-noob-child-comp').handleValueChange();

    }

}