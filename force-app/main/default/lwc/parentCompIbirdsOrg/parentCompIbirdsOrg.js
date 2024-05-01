import { LightningElement , track } from 'lwc';

export default class ParentCompIbirdsOrg extends LightningElement {

    @track fname;
    @track lname;

    handleName(event){

        let nameType = event.currentTarget.name;

        if(nameType == 'fn'){

            this.fname = event.currentTarget.value;
        }else{
            this.lname = event.currentTarget.value;
        }

    }







}