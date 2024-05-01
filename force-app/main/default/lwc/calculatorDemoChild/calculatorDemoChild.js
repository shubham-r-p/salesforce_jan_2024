import { LightningElement , api , track } from 'lwc';

export default class CalculatorDemoChild extends LightningElement {

    @api firstNumber;
    @api secondNumber;

    @track nullVal;

    handleInput(event){

        let boxName = event.target.name;

        if(boxName == 'firstNum'){

            this.firstNumber = event.target.value;
        }
        else{
            this.secondNumber = event.target.value;
        }


        let currentDetail = {
            fNum: this.firstNumber,
            sNum: this.secondNumber
        }

        let customEvent = new CustomEvent('fieldvalue', { detail: currentDetail } )

        this.dispatchEvent(customEvent);
    
    }


    @api inputResetHandler(){

        console.log('inside method')
        console.log('nullVal -->', this.nullVal)
        console.log(this.template.querySelector('.firstVal'));
        this.template.querySelector('.firstVal').value = ''
        console.log(this.template.querySelector('.secondVal'));
        this.template.querySelector('.secondVal').value = ''
        this.nullVal = '';

        // let inOne = document.getElementById("inputOne");
        // let inTwo = document.getElementById("inputTwo");

        // inOne.innerHTML = "";
        // inTwo.innerText = "";


    }




}