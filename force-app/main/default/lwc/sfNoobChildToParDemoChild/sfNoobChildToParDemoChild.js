import { LightningElement } from 'lwc';

export default class SfNoobChildToParDemoChild extends LightningElement {

    multiplyNo;

    handleSubstraction(){

        this.dispatchEvent(new CustomEvent('sub'));
    }


    handleAddition(){

        this.dispatchEvent(new CustomEvent('add'));
    }


    handleButtonClick(event){

        console.log(event.target.dataset.name)

        let buttonName = event.target.dataset.name;

        // if(buttonName == 'two'){

        //     this.multiplyNo = event.target.value;
        // }
        // else if(buttonName == 'three'){

        //     this.multiplyNo = event.target.value;
        // }
        // else if(buttonName == 'four'){

        //     this.multiplyNo = event.target.value;
        // }
        // else{
        //     this.multiplyNo = event.target.value;
        // }


        // this.dispatchEvent(new CustomEvent('mulvalue',{detail : this.multiplyNo}))

        this.dispatchEvent(new CustomEvent('mulvalue',{detail : event.target.value}))

        console.log(this.multiplyNo)
    }


    handleReset(event){

        // let zero = event.target.value;

        this.dispatchEvent(new CustomEvent('reset'))
    }


}