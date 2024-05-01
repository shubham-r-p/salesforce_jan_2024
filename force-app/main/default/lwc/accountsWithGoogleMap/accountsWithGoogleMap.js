import { LightningElement, track, wire } from 'lwc';


import allAccRec from '@salesforce/apex/AccountsGoogleMapTracker.lstAllAccounts'
import getNearByAccounts from '@salesforce/apex/AccountsGoogleMapTracker.getNearByAccounts'

import { loadStyle } from 'lightning/platformResourceLoader';
import LightningCardCSS from '@salesforce/resourceUrl/hideAddressInputt';


export default class AccountsWithGoogleMap extends LightningElement {
    
    @track allAccountRecords = [];
    filteredAccountRecords = []
    kmRange = 100;
    mapMarkers = []
    selctedAddressString = ""
    addressLabel = ""
    mapZoomLevel = ""
    
    renderedCallback() {

        Promise.all([
            loadStyle(this, LightningCardCSS)
        ]).then(() => {
            console.log('Files loaded');
        })
            .catch(error => {
                console.log(error.body.message);
            });
    }
        
    @wire(allAccRec)
    wireHandler(result) {
        if (result.data) {

            console.log("All account records", result.data);
            this.allAccountRecords = result.data;
            this.filteredAccountRecords = result.data;

            this.mapMarkers = this.formatMapMarkers(result.data)
        }
    }

    async handleChange(event) {

        this.selctedAddressString = `${event.target.street}, ${event.target.city} ${event.target.province} ${event.target.postalCode} ${event.target.country}`
        this.addressLabel = `${event.target.street} ${event.target.city} ${event.target.province} ${event.target.postalCode} ${event.target.country}`
    }

    async handleSearchAccounts() {

        const element = this.template.querySelector('.selectedacc');
        if (element) {
            element.classList.remove('selectedacc');
          }

        let response = await fetch(`https://nominatim.openstreetmap.org/search?q=${this.selctedAddressString}&format=json`);

        let items = await response.json();

        console.log("latt longi --> ", items[0]);

        let addressData = items[0]

        getNearByAccounts({ latitude: parseFloat(addressData.lat), longitude: parseFloat(addressData.lon), distance: parseFloat(this.kmRange) })
            .then(result => {
                console.log('searchResults-->', result);

                if (result.length > 0) {
                    this.mapMarkers = this.formatMapMarkers(result)
                    this.filteredAccountRecords = result
                } else {
                    this.mapMarkers = []
                    this.filteredAccountRecords = []
                }
            })
            .catch(error => {
                console.error('Error fetching accounts', error);
            });
    }

    handleRangeChange(event) {
        console.log("km --> ",event.target.value);
        if(event.target.value >= 0) this.kmRange = event.target.value
        else this.kmRange = 100
    }


    handleMarkerSelect(event) {

        const element = this.template.querySelector('.selectedacc');
        if (element) {
            element.classList.remove('selectedacc');
        }

        const customSpan = this.template.querySelector(`div[data-id="${event.detail.selectedMarkerValue}"]`);
        customSpan.classList.add("selectedacc")
        customSpan.scrollIntoView({ behavior: "smooth", block: "end", inline: "nearest" });
    }


    handleClearAddress(){

        const element = this.template.querySelector('.selectedacc');
        if (element) {
            element.classList.remove('selectedacc');
          }

        console.log("inside clear");
        this.selctedAddressString = ""
        this.addressLabel = ""
        this.kmRange = 100
        this.mapMarkers = this.formatMapMarkers(this.allAccountRecords)
        this.filteredAccountRecords = this.allAccountRecords
    }

    formatMapMarkers(accountRecords) {

        return accountRecords.map((account) => {
            return {
                title: account.Name,
                value: account.Id,
                // City: account.BillingAddress.city,
                // Country: account.BillingAddress.country,
                // PostalCode: account.BillingAddress.postalCode,
                // State: account.BillingAddress.state,
                // Street: account.BillingAddress.street,
                description:`${account.BillingAddress.street},<br>${account.BillingAddress.city} ${account.BillingAddress.state} ${account.BillingAddress.postalCode}<br>${account.BillingAddress.country}`,
                location: {
                    Latitude: account.BillingLatitude,
                    Longitude: account.BillingLongitude,
                }
            };
        });
    }


    // mapMarkers = [
    //     {
    //         location: {
    //             City: 'Bengalore',
    //             Country: 'India',
    //             PostalCode: '560031',
    //             State: 'Karnataka',
    //             Street: 'Ibirds Softwere Services, Sarjapur road, Kormangla 1st block',
    //         }
    //         // ,
    //         // mapIcon: {
    //         // path: 'M 125,5 155,90 245,90 175,145 200,230 125,180 50,230 75,145 5,90 95,90 z',
    //         // fillColor: 'gold',
    //         // fillOpacity: .8,
    //         // strokeWeight: 0,
    //         // scale: .10,
    //         // anchor: {x: 122.5, y: 115}
    //         // },
    //     },
    //     {
    //         location: {
    //             City: 'Pune',
    //             Country: 'India',
    //             PostalCode: '411057',
    //             State: 'Maharashtra',
    //             Street: 'Innfosys, Hinjawadi Rajiv Gandhi Infotech Park',
    //         }
    //     },
    //     //         {
    //     //     location: {
    //     //         Latitude: '32.3374755',
    //     //         Longitude: '-86.2161153',
    //     //     },
    //     // },
    //     ];


    // mapMarkers = [
    //     {
    //         location: {
    //             Latitude: '17.153378',
    //             Longitude: '74.281687',
    //         },
    //     },
    //     {
    //         location: {
    //             Latitude: '12.924022',
    //             Longitude: '77.638740',
    //         },
    //     },
    // ];

}