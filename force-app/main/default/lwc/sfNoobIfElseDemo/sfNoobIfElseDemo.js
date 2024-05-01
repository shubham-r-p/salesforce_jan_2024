import { LightningElement , track } from 'lwc';

export default class SfNoobIfElseDemo extends LightningElement {

    @track myLabel = 'Show';
    
    @track ShowCard = false;

    myName = 'Shubham Ramesh Patil';

    handleButtonClick(event){

        let label = event.target.label;

        if(label == 'Show'){

            this.ShowCard = true;
            this.myLabel = 'Hide';

        }
        else if(label == 'Hide'){

            this.ShowCard = false;
            this.myLabel = 'Show';
        }

    }




}