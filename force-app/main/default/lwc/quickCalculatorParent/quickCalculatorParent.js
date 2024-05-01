import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class QuickCalculatorParent extends LightningElement {

    @track value;

    inputLabel;

    inputOne;
    inputTwo;

    result;


    get allOptions() {
        return [
            { label: 'Add (+)', value: 'add' },
            { label: 'Subtract (-)', value: 'sub' },
            { label: 'Multiply (*)', value: 'mul' },
            { label: 'Divide (/)', value: 'div' }

        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        console.log('Combobox value -> ', this.value);

    }

    handleInputs(event) {

        this.inputLabel = event.target.label;
        console.log('Input type -> ', this.inputLabel)
        console.log('Value -> ', event.detail.value)


        if (this.inputLabel == 'Input1') {

            this.inputOne = event.detail.value;
        }
        else {
            this.inputTwo = event.detail.value;
        }
    }


    handleCalculation() {

        if(this.inputOne == '' || this.inputTwo == ''){

            this.dispatchEvent(new ShowToastEvent({

                title:'error',
                message:'Please add values in both Input boxes',
                variant:'warning'
            }))

        }

        if (this.value == 'add') {

            this.result = parseInt(this.inputOne) + parseInt(this.inputTwo)
        }
        else if (this.value == 'sub') {

            this.result = parseInt(this.inputOne) - parseInt(this.inputTwo)

        }
        else if (this.value == 'mul') {

            this.result = parseInt(this.inputOne) * parseInt(this.inputTwo)

        }
        else if (this.value == 'div') {

            this.result = parseInt(this.inputOne) / parseInt(this.inputTwo)

        } else {

            this.dispatchEvent(new ShowToastEvent({

                title: 'error',
                message: 'Please select an option before calculating !',
                variant: 'error'

            }))

        }


        this.template.querySelector('c-quick-calculator-child').handleDispResult(this.result);

    }

}