import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class GuessTheNumberGame extends LightningElement {

    randomNum;
    userNum;
    disableInput = false;
    showButton = true;
    handleWinner = false;
    showGuessLog = false;
    score = 100;
    guessLog;
    resetInputBox;

    connectedCallback(){

        this.generateRandomNum();
    }

    generateRandomNum(){

        this.randomNum = Math.ceil(Math.random() * 100);
        console.log("Random num --> ",this.randomNum);
    }

    handleUserNumber(event){

        this.userNum = parseInt(event.detail.value);
        console.log("User number --> ",this.userNum);
        console.log("Random num --> ",this.randomNum)
    }

    handleRest(){

        this.generateRandomNum();
        this.resetInputBox = null;
        //this.userNum = null;
        //this.userNum = undefined;
        //this.userNum = '';
        this.handleWinner = false;
        this.score = 100;
        this.showGuessLog = true;
    }

    handleGuess(){

        if(this.randomNum == this.userNum){

            this.dispatchEvent(new ShowToastEvent({
                title : "Success",
                message : "Congratulations ! you guessed the number correct. Your score is "+this.score+" !",
                variant : 'success'
            }))

            this.handleWinner = true;
        }
        else if(this.userNum < this.randomNum){

            this.dispatchEvent(new ShowToastEvent({
                title : "Error",
                message : "Please try again ! Your guess is smaller than the random number !",
                variant : 'error'
            }))

            this.guessLog = ' , '+toString(this.userNum);

            this.showGuessLog = true;

            this.score -= 1;
        }
        else if(this.userNum > this.randomNum){

            this.dispatchEvent(new ShowToastEvent({
                title : "Error",
                message : "Please try again ! Your guess is large than the random number !",
                variant : 'warning'
            }))
            this.score -= 1;
            this.guessLog = ' , '+toString(this.userNum);
            this.showGuessLog = true;
        }
    }

}