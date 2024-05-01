import { api, LightningElement, track } from 'lwc';
import returnAccWithConOpp from '@salesforce/apex/lwcControllerTwo.returnAccWithConOpp'
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

const contactsCol = [
    {label:'Con Id' , fieldName:'Id'},
    {label:'Name' , fieldName:'Name'},
    {label:'Phone' , fieldName:'Phone'},
    {label:'Email' , fieldName:'Email'},
]

const opportunitiesCol = [
    {label:'Opp Id' , fieldName:'Id'},
    {label:'Name' , fieldName:'Name'},
    {label:'Amount' , fieldName:'Amount'},
    {label:'Stage' , fieldName:'StageName'},
]

export default class AccRecPageOppConDatatableChild extends LightningElement {

    contactsData;
    opportunitiesData;

    @track recordId;

   @api showDatatables = false;

    conColumns = contactsCol;

    oppColumns = opportunitiesCol;

    oppTempArray = [];
    conTempArray = [];

    connectedCallback(){




    }

    @api showDataTbleFromParent(event){

        this.showDatatables = true;

        this.recordId = event;

        returnAccWithConOpp({ Id : this.recordId })
        .then(data => {
            let tempRecords = data;

            let temp = tempRecords.map(res => {

                return Object.assign({ OppName : res.Opportunities , ConName : res.Contacts })

            } )

            temp.forEach(element => {

                this.oppTempArray = element.OppName;
    
                this.conTempArray = element.ConName;
            } )

            this.contactsData = this.conTempArray;

            this.opportunitiesData = this.oppTempArray;

        })
        .catch(error => {
            
        })





    }


    @api hideDataTables(){


        this.showDatatables = false;


    }



}