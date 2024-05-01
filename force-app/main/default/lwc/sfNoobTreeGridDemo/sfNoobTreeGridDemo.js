import { LightningElement, track , wire} from 'lwc';
import lstAllAccCon from '@salesforce/apex/lwcControllerFour.lstAllAccCon'
import recTypeDevName from '@salesforce/schema/RecordType.DeveloperName'

export default class SfNoobTreeGridDemo extends LightningElement {

    @track allData;


    @track treeGridColumns=[

        {   
            type:'text',
            fieldName:'Name',
            label:'Account Name'
        },
        {   
            type:'text',
            fieldName:'FirstName',
            label:'First Name'
        },
        {   
            type:'text',
            fieldName:'LastName',
            label:'Last Name'
        }
    ]

    connectedCallback(){

        console.log('recordType name--> ',recTypeDevName)


        lstAllAccCon()
        .then(result =>{

            console.log('result json.stringify-->',JSON.parse(JSON.stringify(result)));

            var tempContact = JSON.parse(JSON.stringify(result));

            for(var i=0 ; i<tempContact.length ; i++){

                var newContact = tempContact[i]['Contacts'];

                var newOpportunity = tempContact[i]['Opportunities'];

                console.log('each acc all contacts --> ',newContact)
                console.log('each acc all opportunities --> ',newOpportunity)

                if(newContact){

                   // newContact[i]._children = newOpportunity;

                    tempContact[i]._children = newContact;

                    delete tempContact[i].Contacts;
                }

                // if(newOpportunity){

                //     tempContact[i]._children._children = newOpportunity;

                //     //delete tempContact[i]._children._children.Opportunities;
                // }
            }

            this.allData = tempContact;
            console.log('this.allData -->', JSON.parse(JSON.stringify(this.allData)))

        })

            //var tempContact = JSON.parse(JSON.stringify(result));
    }

    





}