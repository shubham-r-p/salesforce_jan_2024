import { LightningElement , api , track , wire } from 'lwc';
import returnCase from '@salesforce/apex/lwcController3.returnCase';
import caseApi from '@salesforce/schema/Case';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class QuickCaseSearchChild extends LightningElement {

    @track caseApiName = caseApi;
    @track recordId;
    @track openViewForm = false;

    @api returnCase(event){

        returnCase({caseNumber : event})
        .then(responce=>{

            this.recordId = responce;

            this.openViewForm = true;


            console.log(this.recordId)

            this.dispatchEvent(new ShowToastEvent({

                title:'success',
                message:'case fethched successfully !',
                variant:'success'
            }))
        })
        .catch(error=>{

            this.dispatchEvent(new ShowToastEvent({

                title:'error',
                message:'No case exist with entered case number !',
                variant:'error'
            }))

        })



    }






}