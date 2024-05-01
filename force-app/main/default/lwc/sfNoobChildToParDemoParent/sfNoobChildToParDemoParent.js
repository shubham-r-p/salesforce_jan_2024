import { LightningElement , track} from 'lwc';

export default class SfNoobChildToParDemoParent extends LightningElement {

    @track count = 0;

    handleSub(){

        //console.log('inside sub')

        this.count--;
    }

    handleAdd(){

        //console.log('inside add')

        this.count++;
    }

    handleMultiplication(event){

        //console.log(event.detail.value);
        console.log(event.detail);

        this.count = this.count * event.detail;

    }


    handleReset(event){

        this.count = 0;
    }

}