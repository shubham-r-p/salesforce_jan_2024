import { LightningElement, api, track } from 'lwc';
import LightningModal from 'lightning/modal';

export default class MyShowModal extends LightningModal {


    @api content;
    @api product;
    @api options = [];

    @track
    carouselImages = []

    connectedCallback() {

        if(Object.keys(this.content).length>0) this.carouselImages = this.content.images
    }
    
    renderedCallback() {
        
        if(Object.keys(this.content).length>0) this.carouselImages = this.content.images
    }

    handleOkay() {

        console.log("selectedProduct",this.product);

        this.close('okay');
    }


}