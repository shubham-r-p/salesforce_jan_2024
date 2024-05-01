import { LightningElement } from 'lwc';
import returnAllSobjects from '@salesforce/apex/restOrgToOrgIntegrationHandler.returnAllSobjects'
import makePostCallout from '@salesforce/apex/AccountWebServiceTwo.makePostCallout'
import returnSobjects from '@salesforce/apex/AccountWebServiceTwo.returnSobjects'


export default class RestOrgToOrgIntegration extends LightningElement {

    showObjects = true;
    selectedObject;
    showMainMenu = false;
    showRecCresteForm = false;
    fields;
    fieldsObjs;
    allSobjectsTargetOrg;

    async connectedCallback(){
        
        /*returnSobjects()
        .then((res)=>{
            console.log("cus settings from target org --> ",JSON.parse(res));
            let arr = [];
            for (let x of JSON.parse(res)) {
                arr.push({"label":x.Name,"value":x.API_Name__c})
            }
            this.allSobjectsTargetOrg = arr;
        })*/

        console.log("ms --> ",new Date());

        let arr = [];
        for (let x of JSON.parse(await returnSobjects())) {
            arr.push({"label":x.Name,"value":x.API_Name__c})
        }
        this.allSobjectsTargetOrg = arr;

        console.log("ms --> ",new Date());
    }

    handleCombobox(event){

        this.showMainMenu = true;
        this.selectedObject = event.detail.value;
        console.log("obj name --> ",event.detail.value);

        makePostCallout({body:event.detail.value})
        .then((res)=>{

            let arr = [];

            for(let i=0;i<JSON.parse(res).length;i++){
                arr.push({"index":i,"field":JSON.parse(res)[i]})
            }

            console.log("arr for fields --> ",arr);
            this.fieldsObjs = arr;

            console.log("typeof res --> ",typeof JSON.parse(res));
            console.log("lst fields parsed --> ",JSON.parse(res));
            console.log("lst fields --> ",res);
            this.fields = JSON.parse(res);
        })
        .catch((err)=>{
            console.log("Error --> ",err);
        })
    }

    handleCreateRecButton(){
        this.showRecCresteForm = true;
    }


    handleSuccess(event) {
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }

}