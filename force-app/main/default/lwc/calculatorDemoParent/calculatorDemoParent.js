import { LightningElement , track } from 'lwc';

export default class CalculatorDemoParent extends LightningElement {

    @track fNo;
    @track sNo;

    @track result;

    buttonName;


    handleCalculation(event){
        this.fNo = event.detail.fNum;
        this.sNo = event.detail.sNum;
        console.log('fno -->', this.fNo);
        console.log('sno -->', this.sNo)

    }

    handleButtonClick(event){

        this.buttonName = event.target.dataset.name;
        console.log('button name -->', this.buttonName)
        if(this.buttonName == 'Sum'){

            this.result = parseInt(this.fNo) + parseInt(this.sNo);
        }
        if(this.buttonName == 'Min'){

            this.result = parseInt(this.fNo) - parseInt(this.sNo);
        }
        if(this.buttonName == 'Mul'){

            this.result = parseInt(this.fNo) * parseInt(this.sNo);
        }
        if(this.buttonName == 'Div'){

            this.result = parseInt(this.fNo) / parseInt(this.sNo);
        }
    }


    handleReset(){

        this.result = "";

        this.template.querySelector("c-calculator-demo-child").inputResetHandler();

    }




}