import { LightningElement, track , wire} from 'lwc';
import returnContacts from '@salesforce/apex/lwcController.returnContacts'

export default class ShowContactsOnViewShowDetailsParent extends LightningElement {

    @track allConRec;

    @wire(returnContacts)
    wireMethod(result){

        if(result.data){

            this.allConRec = result.data;
            console.log(JSON.stringify(result.data))
        }


    }













}