import { LightningElement , api , wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getContacts from '@salesforce/apex/ContactControllerLWC.getContacts';

export default class ContactSearchAndPaginationLWC extends LightningElement {

    searchKey = ''
    originalContactList = []
    searchedContactList = []
    pageSize = 5
    totalPages
    currentPage
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
        { label: 'Account Name', fieldName: 'AccountName' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    ]
    buttonList = []
    totalRecords = 0
    buttonValue
    lastRecordNumber = 0
    firstRecordNumber = 0

    @wire(getContacts) contacts({ data, error}) {
        if(data){
            this.originalContactList = this.modifyFetchedList(data);
            this.totalRecords = Object.keys(this.originalContactList).length
        } else {
            console.log(error)
        }
    }

    get contactList() {
        this.lastRecordNumber = this.firstRecordNumber + parseInt(this.pageSize)
        if(parseInt(this.pageSize) > this.totalRecords || (this.firstRecordNumber + parseInt(this.pageSize)) > this.totalRecords ){
            this.lastRecordNumber = this.totalRecords;
        }
        if(this.searchKey != ''){
            this.totalPages = Math.ceil(this.totalRecords / parseInt(this.pageSize))
            this.currentPage = Math.ceil(this.firstRecordNumber / parseInt(this.pageSize)) + 1
            return this.searchedContactList.slice(this.firstRecordNumber, this.lastRecordNumber)
        } else {
            this.totalPages = Math.ceil(this.totalRecords / parseInt(this.pageSize))
            this.currentPage = Math.ceil(this.firstRecordNumber / parseInt(this.pageSize)) + 1
            return this.originalContactList.slice(this.firstRecordNumber, this.lastRecordNumber)
        }
    }

    get pageNumbers() {
        return [
            {label : '5', value : 5},
            {label : '10', value : 10},
            {label : '15', value : 15},
            {label : '20', value : 20},
            {label : '100', value : 100}
        ]
    }

    handlePageSize(event) {
        this.pageSize = parseInt(event.target.value)
        this.firstRecordNumber = 0
    }

    handleSearch() {
        this.searchKey = this.template.querySelector(".searchText").value
        this.firstRecordNumber = 0;
        this.totalRecords = Object.keys(this.originalContactList).length
        if(this.searchKey != ''){
            getContacts({ searchText: this.searchKey}).then(result => {
                this.searchedContactList = this.modifyFetchedList(result)
                this.firstRecordNumber = 0;
                this.totalRecords = Object.keys(this.searchedContactList).length
                if(this.totalRecords <= 0){
                    const evt = new ShowToastEvent({
                        title: 'No Contacts Available',
                        message: 'Sorry no contacts available with that Name or Email',
                        variant: 'error',
                    });
                    this.dispatchEvent(evt);
                }
            }).catch(error => {
                console.log(error)
            })
        }
    }

    handleFirst() {
        this.firstRecordNumber = 0
    }

    handleLast() {
        this.firstRecordNumber = this.totalRecords - (this.totalRecords % this.pageSize) 
    }

    handleNext() {
        this.firstRecordNumber +=  this.pageSize;
    }

    handlePrevious() {
        this.firstRecordNumber -=  this.pageSize;
    }

    get showNextButton() {
        if((this.firstRecordNumber + this.pageSize) >= this.totalRecords){
            return true;
        } else {
            return false;   
        }
    }

    get showPreviousButton() {
        if(this.firstRecordNumber == 0){
            return true;
        } else {
            return false;
        }
    }

    get updateButtonList() {
        this.buttonList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        var totalButtons = Math.ceil(this.totalRecords / this.pageSize)
        if(totalButtons >= 1 && totalButtons <= 10){
            this.buttonList = []
            for(var number = 1; number <= totalButtons; number++){
                this.buttonList.push(number)
            }
        }
        return this.buttonList;
    }
    
    handleGoToNumber(event) {
        this.buttonValue = event.target.value
        this.firstRecordNumber = this.pageSize * (this.buttonValue - 1) 
    }

    modifyFetchedList(data) {
        let modifiedContactData = []
            data.forEach(row => {
                let rowData = {}
                rowData.Id = row.Id
                rowData.Name = row.Name
                rowData.Email = row.Email
                rowData.Phone = row.Phone
                rowData.Type__c = row.Type__c
                if (row.Account){ 
                    rowData.AccountName = row.Account.Name
                }
                modifiedContactData.push(rowData)
            })
        return modifiedContactData
    }


}