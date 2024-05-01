import { LightningElement , api , track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertCon from '@salesforce/apex/lwcControllerFour.insertCon';
import lstContactFields from '@salesforce/apex/lwcControllerFour.lstContactFields';

import { CloseActionScreenEvent } from 'lightning/actions';

export default class ButtonActionDemo extends NavigationMixin(LightningElement) {

     showModal = true;

     Name;

     allFields;

    //  accRec = {};

    connectedCallback(){

            lstContactFields()
           .then(result=>{

            this.allFields = result;

            console.log('all fields-->',this.allFields)
           })


    }    



     handleSuccess(event) {

        this.showModal = false;

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Contact',
                actionName: 'view'
            },
        });
   
        this.dispatchEvent(new ShowToastEvent({

             title:'Success',
             message:'Contact created successfully ! with Id '+event.detail.id,
             variant:'success'
         }))
    }

    handleError(event) {

        this.showModal = false;

        // let data = event.detail;
        // console.log(JSON.stringify(data));

        // let toastEvent = new ShowToastEvent({
        //     title: 'Error',
        //     message: data.message,
        //     variant: 'error'
        // });

        // this.dispatchEvent(toastEvent);

                  this[NavigationMixin.Navigate]({
               type: 'standard__objectPage',
               attributes: {
                   objectApiName: 'Contact',
                   actionName: 'list'
               },
               state: {
                   filterName: 'Recent'
               },
           });
    }
}

    //  handleInputs(event){
  
    //            this.Name = event.detail.value;
    //            console.log('Name-->',this.Name) 
    //  }


    //    handleSave(e) {

    //                 if(this.Name == null){

    //            this.dispatchEvent(new ShowToastEvent({
    //                 title:'Warning',
    //                 message:'Please insert Name !',
    //                 variant:'error'
    //             }))
    //             this.dispatchEvent(new CloseActionScreenEvent());

    //       }
    //       else{
    //         // Close the modal window and display a success toast
    //       //   this.dispatchEvent(new CloseActionScreenEvent());

    //         this.showModal = false;


    //         this.accRec = {
    //            'sobjectType' : 'Account',
    //            'Name' : this.Name
    //        }

    //        insertCon({acc : this.accRec})
    //        .then(result=>{

    //                 this[NavigationMixin.Navigate]({
    //                     type: 'standard__recordPage',
    //                     attributes: {
    //                         recordId: result,
    //                         objectApiName: 'Account',
    //                         actionName: 'view'
    //                     },
    //                 });
               
    //                 this.dispatchEvent(new ShowToastEvent({

    //                      title:'Success',
    //                      message:'Contact created successfully ! with Id '+result,
    //                      variant:'success'
    //                  }))
    //        })
    //        .catch(error=>{

    //            this.dispatchEvent(new ShowToastEvent({

    //                 title:'Error',
    //                 message:'Please insert required fields !',
    //                 variant:'error'
    //             }))
    //        })

    //        this.dispatchEvent(new CloseActionScreenEvent());
    //       }
    //    }

    //    handleCancel(){

    //       this.showModal = false;

    //       this[NavigationMixin.Navigate]({
    //            type: 'standard__objectPage',
    //            attributes: {
    //                objectApiName: 'Account',
    //                actionName: 'list'
    //            },
    //            state: {
    //                filterName: 'Recent'
    //            },
    //        });
    //    }