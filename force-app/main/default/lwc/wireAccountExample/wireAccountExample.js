import { LightningElement, wire, track } from 'lwc';
import GET_ACCOUNT from '@salesforce/apex/lwcController.returnContacts';


export default class WireAccountExample extends LightningElement {

    @track title;
    @track lstAccount = new Array();
    @track error;

    @wire(GET_ACCOUNT)
    WireAccounts(result) {
        // Result includes = data, error
        if(result) {
            if(result.data) {
                // this.lstAccount = result.data;
                
                for(let acc of result.data) {
                    let account = Object.assign({}, acc);
                    account['URL'] = window.location.origin + '/lightning/r/Account/' + acc.Id + '/view';
                    this.lstAccount.push(account);
                }

                this.title = 'All Accounts (' + result.data.length + ')';
            } else if(result.error) {
                this.error = result.error;
                this.title = 'All Accounts (0)';
            }
        }

    }

}