import { LightningElement , wire } from 'lwc';
import returnCases from '@salesforce/apex/closeCasesWrappClassDemo.returnCases'
import closeSelectedCases from '@salesforce/apex/closeCasesWrappClassDemo.closeSelectedCases'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getDataConnectorSourceFields } from 'lightning/analyticsWaveApi';
// import ShowContactsOnViewShowDetailsChild from '../showContactsOnViewShowDetailsChild/showContactsOnViewShowDetailsChild';

export default class CloseCasesWrapperClassDemo extends LightningElement {

    err;
    cases;
    wiredValue;

    @wire(returnCases)
    wiredData(result){
        this.wiredValue = result
        let {data, error} = result
        if(data){

            console.log('data \n ',data);
            this.cases = JSON.parse(JSON.stringify(data)) ;
        }
        else if(error){

            console.log('error \n ',error);
        }

    }


    handleClick = event =>{

        event.preventDefault();

        console.log('Updated ==> ',this.cases)

        closeSelectedCases({lstSelectedCases : JSON.stringify(this.cases)})
        .then(res=>{

            console.log('Final Updated ==> ',res)

            this.dispatchEvent(new ShowToastEvent({

                title:'Success',
                message:'Selected Cases closed successfully !',
                variant: 'success'
            }))  
            
            // window.location.reload();
            refreshApex(this.wiredValue);
        })
        .catch(err=>{

            console.log('Error ==> ',err)

            this.dispatchEvent(new ShowToastEvent({

                title:'Error',
                message:'Updation failed !',
                variant: 'error'
            }))
        })

    }


    handleCheckBox = event =>{
        console.log('in handle check box')
        event.preventDefault();

        // in JS data- => dataset-
        console.log('event.target.name -->', event.target.name);
        console.log('event.target.checked -->', event.target.checked);
        console.log('event.target.dataset.Id -->', event.target.dataset.id)

        let name = event.target.name;           // isSelected
        let checked = event.target.checked;     // on change itll return boolean depending on value of checkbox
        let index = event.target.dataset.id;    // index of wrapper array

        this.cases[index][name] = checked;
        
    }



}