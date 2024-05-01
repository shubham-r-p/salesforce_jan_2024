import { LightningElement , wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { createRecord } from 'lightning/uiRecordApi';

import { updateRecord } from 'lightning/uiRecordApi';

import { getRecord,deleteRecord } from 'lightning/uiRecordApi';


import accObjectApiName from '@salesforce/schema/Account';
import accObjectName from '@salesforce/schema/Account.Name';
import accObjectAccNumber from '@salesforce/schema/Account.AccountNumber'
import accObjectAccId from '@salesforce/schema/Account.Id'
import accObjectAccIndustry from '@salesforce/schema/Account.Industry';
import accObjectAccPhone from '@salesforce/schema/Account.Phone'
import accObjectAccOwner from '@salesforce/schema/Account.Owner.Name'


const allFieldsArray = [ accObjectName,accObjectAccId,accObjectAccIndustry,accObjectAccPhone,accObjectAccOwner];


export default class SfNoobUiRecordApiDemo extends LightningElement {
    recordId;

    accName;

    accNameUp;
    accIdUp;
    accNumUp;

    dataAccount;

    accDetailGetDelete;
    accNameGetDelete;
    accIdGetDelete;
    accIndustryGetDelete;
    accPhoneGetDelete;
    accOwnerGetDelete;

    accDelId;

    handleAccountName(event){

        this.accName = event.detail.value;
    }

    handleId(event){

        this.accIdUp = event.detail.value;
    }

    handleAccName(event){

        this.accNameUp = event.detail.value;
    }

    handleAccNum(event){

        this.accNumUp = event.detail.value;
    }

    handleAccountDelId(event){

        this.accDelId = event.detail.value;
    }
    

    handleAccUpdation(event){

        const fields = {};

        fields[accObjectAccId.fieldApiName] = this.accIdUp;
        fields[accObjectName.fieldApiName] = this.accNameUp;
        fields[accObjectAccNumber.fieldApiName] = this.accNumUp;

        const recordInput = {fields};

        updateRecord(recordInput)
        .then(result =>{

            console.log('result--> ',result)
        })
        .catch(error =>{

            window.alert(error)
        })


    }



    handleAccCreation(event){   

        if(event.detail.value == null){

            this.dispatchEvent(new ShowToastEvent({

                title:'error',
                message:'Please fill Account Name before inserting !',
                variant:'warning'
            }))
        }

        const fields = {};

        fields[accObjectName.fieldApiName] = this.accName;

        createRecord({apiName : accObjectApiName.objectApiName , fields })
        .then(result =>{

            this.recordId = result.id;

            this.dispatchEvent(new ShowToastEvent({

                title:'success',
                message:'Account record created successfully ! with id '+this.recordId,
                variant:'success'
            }))
        })
    }


    //get and delete record

    
    @wire(getRecord,{recordId: '0015i00000TLy6uAAD' , fields:allFieldsArray})
    wireAcc({error,data}){

        if(data){
            this.accDetailGetDelete = data;

            this.accNameGetDelete = this.accDetailGetDelete.fields.Name.value;
            this.accIdGetDelete = this.accDetailGetDelete.fields.Id.value;
            this.accIndustryGetDelete = this.accDetailGetDelete.fields.Industry.value;
            this.accPhoneGetDelete = this.accDetailGetDelete.fields.Phone.value;
            this.accOwnerGetDelete = this.accDetailGetDelete.fields.Owner.DisplayValue;

        }
        else{
            //window.alert(error);
        }
    }

    deleteAccount(){

        deleteRecord(this.accIdGetDelete)
        .then(result=>{

            window.alert('Record deleted successfully !');
        })
        .catch(error=>{

            window.alert(JSON.stringify(error));
        })


    }


    resetHandler(){

        this.recordId = undefined;
        this.accName = undefined;

        this.accIdUp = undefined;
        this.accNameUp = undefined;
        this.accNumUp = undefined;
    }



}