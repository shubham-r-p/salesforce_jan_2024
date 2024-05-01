import { LightningElement, track, api } from 'lwc';

export default class SldsDemo extends LightningElement {


@track carouselData = [
    {
        img: "abc.com",
        heading: "test 1",
        content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here"
    },
    {
        img: "abc.com",
        heading: "test 2",
        content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here"
    },
    {
        img: "abc.com",
        heading: "test 3",
        content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here"
    },
]

cards = [
    {
        id: '1',
        title: 'Card 1',
        icon: 'standard:account',
        content: 'It is card 1 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1460472178825-e5240623afd5?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '2',
        title: 'Card 2',
        icon: 'standard:contact',
        content: 'It is card 2 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1486325212027-8081e485255e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '3',
        title: 'Card 3',
        icon: 'standard:lead',
        content: 'It is card 3 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1460472178825-e5240623afd5?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '4',
        title: 'Card 4',
        icon: 'standard:contact',
        content: 'It is card 4 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1486325212027-8081e485255e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '5',
        title: 'Card 5',
        icon: 'standard:contact',
        content: 'It is card 5 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1460472178825-e5240623afd5?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '6',
        title: 'Card 6',
        icon: 'standard:account',
        content: 'It is card 6 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1486325212027-8081e485255e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
        id: '7',
        title: 'Card 7',
        icon: 'standard:contact',
        content: 'It is card 7 a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using',
        img: "https://images.unsplash.com/photo-1460472178825-e5240623afd5?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    }
];

activeIndex = 0;

handlePreviousBtn() {
    if (this.activeIndex > 0) {
        this.activeIndex--;
    }
    this.updateCardPosition(this.activeIndex);
}

handleNextBtn() {
    if (this.activeIndex < this.cards.length - 3) {
        this.activeIndex++;
    }
    this.updateCardPosition(this.activeIndex);
}

get cardsToShow() {
    return this.cards.slice(this.activeIndex, this.activeIndex + 3);
}


@api
get slidesData() {
  return this.cards;
}

set slidesData(data) {
  this.cards = data.map((slide, i) => {
    if (i === 0) {
      return {
        ...slide,
        index: i + 1,
        slideClass: 'fade slds-show',
        dotClass: 'dot active'
      };
    }
    return {
      ...slide,
      index: i + 1,
      slideClass: 'fade slds-hide',
      dotClass: 'dot'
    };
  });
}

updateCardPosition(activeIndex) {
    console.log("inside trans",activeIndex);
    const container = document.querySelector('.card-container');
    container.style.transform = `translateX(-${activeIndex * 25}%)`;
}

}

