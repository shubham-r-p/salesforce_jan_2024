import { LightningElement , track , api } from 'lwc';

export default class AccRecPageOppConDatatableParent extends LightningElement {

    @api recordId;

    @track buttonLabel = 'Show';

    handleButtonClick(event){

        if(event.target.label == 'Show'){

            this.buttonLabel = 'Hide';
            this.template.querySelector('c-acc-rec-page-opp-con-datatable-child').showDataTbleFromParent(this.recordId);
        }
        else if(event.target.label == 'Hide'){

            this.buttonLabel = 'Show';

            this.template.querySelector('c-acc-rec-page-opp-con-datatable-child').hideDataTables();

        }





    }





}