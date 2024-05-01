trigger caseAssignmentCase on Case (before insert , before update) {


    if(Trigger.isInsert && Trigger.isBefore){

        caseAssignmentCaseHandler.doBeforeInsert(Trigger.new);
    }


    /*if(Trigger.isUpdate && Trigger.isBefore){

        caseAssignmentCaseHandler.assignCaseGroupName(Trigger.new);
    }*/

}