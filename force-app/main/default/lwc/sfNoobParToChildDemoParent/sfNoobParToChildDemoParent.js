import { LightningElement, track } from 'lwc';

export default class SfNoobParToChildDemoParent extends LightningElement {

    @track inputVal;

    handleInputChange(event){

        this.inputVal = event.target.value;
    }


    handleAddition(event){

        let buttonLabel = event.target.label;

        // console.log(buttonLabel)
        // console.log(this.buttonLabel)

        
        if(buttonLabel == '33'){

                this.template.querySelector('c-sf-noob-par-to-child-demo-child').additionHandler(33);
                // this.inputVal = parseInt(this.inputVal) + 33;
        }
        else if(buttonLabel == '66'){

            this.template.querySelector('c-sf-noob-par-to-child-demo-child').additionHandler(66);
                // this.inputVal = parseInt(this.inputVal)  + 66;
        }
        else if(buttonLabel == '99'){

            this.template.querySelector('c-sf-noob-par-to-child-demo-child').additionHandler(99);
                // this.inputVal = parseInt(this.inputVal)  + 99;
        }
    }


    resetHandler(){

    this.inputVal = '';

    this.template.querySelector('c-sf-noob-par-to-child-demo-child').resetInput();
    }




}