import { LightningElement, track } from 'lwc';
import returnAllAcc from '@salesforce/apex/lwcControllerTwo.returnAllAcc';
import returnAccWithConOpp from '@salesforce/apex/lwcControllerTwo.returnAccWithConOpp'

// import accObjApi from '@salesforce/schema/Account'
// import accNameApi from '@salesforce/schema/Account.Name'
// import accPhoneApi from '@salesforce/schema/Account.Phone'
// import accNoApi from '@salesforce/schema/Account.AccountNumber'
// import accFaxApi from '@salesforce/schema/Account.Fax'
// import accStateApi from '@salesforce/schema/Account.BillingState'
// import accCityApi from '@salesforce/schema/Account.BillingCity'


export default class AccComboboxRecViewFormConOppTable extends LightningElement {

    showRecViewForm = false;
    showConTable = false;
    showOppTable = false;

    // accObj = accObjApi;
    // nameField = accNameApi;
    // phoneField = accPhoneApi;
    // accNoField = accNoApi;
    // faxField = accFaxApi;
    // stateField = accStateApi;
    // cityField = accCityApi;

    accountToDisplay;

    @track options;

    accRecId;

    oppTempArray = [];
    conTempArray = [];

    @track lstContact = new Array();
    @track lstOpportunities = new Array();


    connectedCallback(){

        returnAllAcc()
        .then(responce => {

            let arr = [];

            for(var i=0;i<responce.length;i++){

                arr.push({label:responce[i].Name , value:responce[i].Id})
            }
                this.options = arr;
        })
    }

    handleChange(event){

        this.accRecId = event.detail.value;

        returnAccWithConOpp({ Id : this.accRecId })
        .then(data => {
            let tempRecords = data;

            console.log('tempRecords -->', tempRecords)

            this.accountToDisplay = {
                'Name' : tempRecords[0].Name,
                'Phone' : tempRecords[0].Phone,
                'AccountNumber' : tempRecords[0].AccountNumber,
                'Fax' : tempRecords[0].Fax,
                'BillingState' : tempRecords[0].BillingState,
                'BillingCity' : tempRecords[0].BillingCity,
            }

            this.showRecViewForm = true;
            console.log('after account data')
            for(const each of tempRecords){
                //if(each.hasOwnProperty('Opportunities') && each.Opportunities.length > 0 ){
                console.log('in for', each)
                // console.log('oppo ->', each.Opportunities.length)
                console.log('after opp')
                //if(each.Opportunities != undefined ){

                    if( each.hasOwnProperty('Opportunities') ){
                    console.log('in first if')
                    this.lstOpportunities = each.Opportunities;
                    this.showOppTable = true
                    console.log('lstOpp --> ',this.lstOpportunities)
                }else{
                    console.log('in else')
                    this.showOppTable = false
                }
                console.log('in for after first if')
                
                if( each.hasOwnProperty('Contacts') ){
                    console.log('in second if')
                    this.lstContact = each.Contacts;
                    this.showConTable = true;
                    console.log('lstCon --> ',this.lstContact)
                }else {
                    console.log('in seconde else')
                    this.showConTable = false;
                }
            }
            console.log('after for loop')
            // let temp = tempRecords.map(res => {

            //     return Object.assign({ OppName : res.Opportunities , ConName : res.Contacts })

            // } )
            // console.log('temp -->', temp);
            // temp.forEach(element => {

            //     this.oppTempArray = element.OppName;
    
            //     this.conTempArray = element.ConName;
            // } )
            // console.log('temp after for each ->', temp)
            // this.lstContact = this.conTempArray;
            // if(this.conTempArray == null ){
            //     this.showConTable = false;
            // }
            // else{
            //     this.showConTable = true;
            // }

            // this.lstOpportunities = this.oppTempArray;
            // if(this.oppTempArray == null ){
            //     this.showOppTable = false;
            // }
            // else{
            //     this.showOppTable = true;
            // }

        })
        .catch(error => {
            
        })
    }
}