import { LightningElement , api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordViewEditFormIbirdsOrg extends LightningElement {

    @api recordId;
    @api objectApiName;



    handleSuccess(event){


        let successEvent = new ShowToastEvent({

            title: 'Success',
            message: 'Updated successfully !',
            variant: 'success'
        })

        this.dispatchEvent(successEvent);
    }

    handleError(event){


        let errorEvent = new ShowToastEvent({

            title: 'Error',
            message: 'Update failed please correct your data !',
            variant: 'error'
        })

        this.dispatchEvent(errorEvent);
    }











}