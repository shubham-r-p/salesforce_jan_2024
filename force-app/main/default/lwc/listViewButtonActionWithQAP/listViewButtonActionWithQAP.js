import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class ListViewButtonActionWithQAP extends LightningElement {

 
    handleSuccess(e) {
         // Close the modal window and display a success toast
         this.dispatchEvent(new CloseActionScreenEvent());

         this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: e.detail.id,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
   
        this.dispatchEvent(new ShowToastEvent({

             title:'Success',
             message:'Contact created successfully ! with Id '+result,
             variant:'success'
         }))



    }


    handleCancel(e){

        this.dispatchEvent(new CloseActionScreenEvent());
    }
 }