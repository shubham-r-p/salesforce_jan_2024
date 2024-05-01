import { LightningElement , wire , track} from 'lwc';

import lstContacts from '@salesforce/apex/lwcController.returnContacts';

export default class WireServiceDemoIbirdsorg extends LightningElement {

    @track arrayContacts = new Array();
    @track contactCount;


    
    @wire(lstContacts) 
    //arrayContactHandler({error, data}){
    arrayContactHandler(result){

        if(result){
                if(result.data){

               this.arrayContacts = result.data;
               this.contactCount = 'Wired Contacts ('+ result.data.length +')';
            }else{
                this.contactCount = 'Wired Contacts (0)';
            }
        }

        /*if(data){
            console.log('data -->', data)
                 this.arrayContacts = data;

            console.log(this.arrayContacts);
        }
        else {
            console.log(error)
        }*/
    }







}