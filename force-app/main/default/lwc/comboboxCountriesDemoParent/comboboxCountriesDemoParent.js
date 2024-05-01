import { LightningElement , track , api } from 'lwc';

export default class ComboboxCountriesDemoParent extends LightningElement {

    value;

    get comboboxOptions() {
        return [
            { label: 'India', value: 'ind' },
            { label: 'Pakistan', value: 'pak' },
            { label: 'Bangladesh', value: 'bd' },
            { label: 'Sri Lanka', value: 'sl' },
            { label: 'China', value: 'chi' }
        ]
    }

    handleChange(event){

        this.value = event.detail.value; 
        console.log(this.value)
    }

    handleButtonClick(){

        this.template.querySelector('c-combobox-countries-demo-child').showCountryDetail(this.value);


    }

}