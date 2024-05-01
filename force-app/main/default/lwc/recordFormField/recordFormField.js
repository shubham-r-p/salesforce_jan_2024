import { LightningElement , api } from 'lwc';

export default class RecordFormField extends LightningElement {

@api fieldLabel;

@api fieldApiName;

handleValueChange(event){

    console.log(this.fieldApiName +' => '+ event.currentTarget.value +' | fieldLabel => '+this.fieldLabel);


    /*let currentDetail = {
        apiName : this.fieldApiName,
        value : event.currentTarget.value
    }*/




    let newCustomEvent = new CustomEvent( 'fieldvalue' , { detail :  {  apiName : this.fieldApiName,
                                                                        value : event.currentTarget.value } })

    this.dispatchEvent(newCustomEvent);

}



}