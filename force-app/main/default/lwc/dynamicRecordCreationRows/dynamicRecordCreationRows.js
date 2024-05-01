import { LightningElement , track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DynamicRecordCreationRows extends NavigationMixin(LightningElement) {

    keyIndex = 0;

    @track itemList = [
        {
            id: 0
        }
        
        // , {
        //     id : 1
        // }, {
        //     id: 2
        // }
    ];

    addRow() {

        ++this.keyIndex;

        console.log('incremented keyIndex--> ',this.keyIndex)

        //array
        var newItem = [{ id: this.keyIndex }];

        console.log('new item--> ',newItem)

        this.itemList = this.itemList.concat(newItem);

        console.log('updated item list--> ',JSON.stringify(this.itemList))
    }

    removeRow(event) {
        if (this.itemList.length >= 2) {
            this.itemList = this.itemList.filter(function (element) {

                console.log('eachElement--> ',JSON.stringify(element))

                console.log('element id !== accessKey ',element.id , event.target.accessKey);

                return parseInt(element.id) !== parseInt(event.target.accessKey);


                //element
                //element.id & access key 
                // returns filtered array depending on boolean condition
            });
        }
    }

    handleSubmit() {
        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {

            console.log('handleSubmit--> ',JSON.stringify(element))

            isVal = isVal && element.reportValidity();
            //
        });
        if (isVal) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                //
                element.submit();
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contacts successfully created',
                    variant: 'success',
                }),
            );
            // Navigate to the Account home page
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Contact',
                    actionName: 'home',
                },
            });
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'Please enter all the required fields',
                    variant: 'error',
                }),
            );
        }
    }

}