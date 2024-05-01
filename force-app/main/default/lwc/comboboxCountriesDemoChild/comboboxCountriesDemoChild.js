import { LightningElement , track , api } from 'lwc';
import 	allFlags from '@salesforce/resourceUrl/flags';   

export default class ComboboxCountriesDemoChild extends LightningElement {

    @track displayData;

    @track allData = {

        'ind' : {
            'img' : allFlags+'/ind.png',
            'country' : 'India',
            'capital' : 'Delhi',
            'population' : '138 Crores'
        },
        'pak' : {
            'img' : allFlags+'/pk.png',
            'country' : 'Pakistan',
            'capital' : 'Lahore',
            'population' : '22 Crores'
        },
        'bd' : {
            'img' : allFlags+'/bd.png',
            'country' : 'Bangladesh',
            'capital' : 'Dhaka',
            'population' : '16 Crores'
        },
        'sl' : {
            'img' : allFlags+'/sl.png',
            'country' : 'Sri Lanka',
            'capital' : 'Colombo',
            'population' : '2.19 Crores'
        },
        'chi' : {
            'img' : allFlags+'/chi.png',
            'country' : 'China',
            'capital' : 'Shanghai',
            'population' : '140 Crores'
        }
    }
    

    @api showCountryDetail(event){
        
        console.log(event)
        console.log('this.displayData[value]-->'+this.allData[event].country)

        this.displayData = this.allData[event]

        console.log(this.displayData)
    }

}