import { LightningElement , track } from 'lwc';

export default class SfNoobTrackDemo extends LightningElement {


    @track personInfo = {

        fName: "",
        lName: "",
        phone: ""
    }


    handleChange(event){

        let inputName = event.target.name;

        //window.alert(inputName);

        if(inputName == 'fname'){

            this.personInfo.fName = event.target.value;        
        }
        else if(inputName == 'lname'){

            this.personInfo.lName = event.target.value;        
        }
        else if(inputName == 'Phone'){

            this.personInfo.phone = event.target.value;        
        }

    }



}