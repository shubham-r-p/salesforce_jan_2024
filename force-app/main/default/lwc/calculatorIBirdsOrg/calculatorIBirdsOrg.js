import { LightningElement , track } from 'lwc';

export default class CalculatorIBirdsOrg extends LightningElement {

    num1;
    num2;

    @track ans;

    handleCal(event){

        let numName = event.currentTarget.name;

        let value = parseInt(event.currentTarget.value);

        if(numName == 'numOne'){
            this.num1 = value;
        }else{
            this.num2 = value;
        }
        //console.log('numName',numName)
    }



    performOperation(event){

        let buttonName = event.currentTarget.name;

        if(buttonName == 'Add'){

            this.addition();
        }
        else if(buttonName == 'Sub'){

            this.subtraction();
        }
        else if(buttonName == 'Div'){

            this.divisionn();
        }
        else if(buttonName == 'Mul'){

            this.multiply();
        }


    }


    addition(){

        this.ans = this.num1 + this.num2;

    }

    subtraction(){
        this.ans = this.num1 - this.num2;
    }

    divisionn(){
        this.ans = this.num1 / this.num2;
    }

    multiply(){
        this.ans = this.num1 * this.num2;
    }







}