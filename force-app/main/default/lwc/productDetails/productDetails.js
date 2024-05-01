import { LightningElement, track } from 'lwc';
import MyShowModal from "c/myShowModal";

export default class ProductDetails extends LightningElement {

    allProducts = []
    filteredProducts = [];
    value = "all";
    showNoItemsMsg = false
    showModal = false


    async connectedCallback() {
        console.log("Inside ccb");

        const response = await fetch("https://dummyjson.com/products")
        const result = await response.json()

        this.allProducts = result.products
        this.filteredProducts = result.products

        console.log("Product data --> ",result);
    }

    get options() {
        let temp = [{ label: "All categories", value: "all" }]

        this.allProducts.forEach(product => {
            if (temp.filter((option) => option.value === product.category).length === 0) {
                temp.push(
                    { label: product.category.charAt(0).toUpperCase() + product.category.slice(1), value: product.category })
            }
        })
        return temp
    }

    async handleClick(event) {
        console.log('event',event.currentTarget.dataset.recid);

        let selectedProduct = this.allProducts.filter((product) => product.id == event.currentTarget.dataset.recid)[0]

        console.log("selectedProduct --> ",selectedProduct);

        const result = await MyShowModal.open({
            // `label` is not included here in this example.
            // it is set on lightning-modal-header instead
            size: 'small',
            description: 'Accessible description of modal\'s purpose',
            content: selectedProduct,
            options: selectedProduct.images
        });
        // if modal closed with X button, promise returns result = 'undefined'
        // if modal closed with OK button, promise returns result = 'okay'
        console.log(result);
    }

    searchHandle(event) {

        this.filteredProducts = this.allProducts.filter((product) =>
            product.title.toLowerCase().includes(event.target.value.toLowerCase().trim())
            || product.brand.toLowerCase().includes(event.target.value.toLowerCase().trim())
            || product.category.toLowerCase().includes(event.target.value.toLowerCase().trim())
        )

        if(this.filteredProducts.length===0) this.showNoItemsMsg = true
        else this.showNoItemsMsg = false
    }

    handleComboboxChange(event) {
        this.value = event.detail.value;

        if(event.detail.value === "all") this.filteredProducts = this.allProducts
        else this.filteredProducts = this.allProducts.filter((product) => product.category === event.detail.value)

        if(this.filteredProducts.length===0) this.showNoItemsMsg = true
        else this.showNoItemsMsg = false
    }

    handleShowModal(event) {

        this.showModal = true

        console.log("inside card click ");

        console.log("e target --> ",event.target.value);
        console.log("e detail --> ",event.detail.value);
    }

    handleCloseModal() {
        this.showModal = false
    }

}