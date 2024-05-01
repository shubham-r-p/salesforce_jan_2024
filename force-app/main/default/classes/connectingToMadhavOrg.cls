public class connectingToMadhavOrg {
    
    public static void sendCase(){
        
        Http ht = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        
        //req.setEndpoint('callout:TestingConnectedApp');
        req.setEndpoint('callout:connectMadhavOrg/services/apexrest/caseinfo/');
        req.setBody('test abc123');
        req.setMethod('GET');
        
        res = ht.send(req);
        
        system.debug('res --> '+res);
    }
    
    
    
    

}






//ublic class GetCaseInfoFromOldOrg {
    /* getCaseInfo Method to send the request to the old org and get the case details of records of a specified 
        case Number which we will send in the method parameter */
/*AuraEnabled(cacheable = true)
    public static Case getCaseInfo(String searchCase){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Ibirds_Connected_App/services/apexrest/caseinfo/?caseNum='+searchCase);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        System.debug(JSON.deserializeUntyped(res.getBody()));
        // case a = JSON.deserializeUntyped(res.getBody());
        Case a = (Case)JSON.deserialize(res.getBody(), Case.Class);
      //  case c= new case();
        return a;
    }*/

    /* sendCaseInfo Method to send the edited case details and save in the old org  */
/*  @AuraEnabled(cacheable = true)
    public static string sendCaseInfo(Case caseObj){
       // system.debug('edited case object==>'+caseObj.Priority);
       // system.debug('edited case object Id==>'+caseObj.Id);
       //system.debug('edited case object==>'+caseObj);
       string str = JSON.serialize(caseObj);
       //system.debug('str'+str);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Ibirds_Connected_App/services/apexrest/caseinfo/?caseId='+caseObj.Id);
        req.setMethod('PATCH');//When case is updated that time used PATCH
        req.setBody(str);
       // req.setHeader(key, value);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('response::'+res.getBody());
        return str;
    }*/
    
    /*deleteCaseInfo Method to pass the caseId to the old org so that from the 
        old org the case record will get deleted */
 /* @AuraEnabled(cacheable=true)
    public static string deleteCaseInfo(Case caseObj){
        system.debug(' case object Id to be deleted==>'+caseObj.Id);
        system.debug('case object to be deleted==>'+caseObj);
        string str = JSON.serialize(caseObj);
        system.debug('strr'+str);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Ibirds_Connected_App/services/apexrest/caseinfo/?caseId='+caseObj.Id);
        req.setMethod('DELETE');// When we want delete case that time used
        req.setBody(str);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('response:::'+res.getBody());
        return str;
    }

    @AuraEnabled(cacheable=true)
    public static string uploadCaseInfoWithDocument(String filename,String  base64,String recordId){*/
        // System.debug('in uploadCaseInfoWithDocument method');
        // System.debug('filename ==>> '+filename);
  /*   System.debug('base64 ==>> '+base64);
        string str = JSON.serialize(recordId);
        //blob formBlob = EncodingUtil.base64Decode(base64);
        HttpRequest req = new HttpRequest();
        filename = filename.replace(' ', '+');
        System.debug('filename ==>> '+filename);
        req.setEndPoint('callout:Ibirds_Connected_App/services/apexrest/caseinfo/?recordId='+recordId +'&filename='+filename );
        req.setMethod('POST');//When we want upload any attchment that time we used POST
        req.setBody(base64);
        req.setHeader('Content-Transfer-Encoding','base64');
        // req.setBody();
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('response:: ==>> '+res.getBody());
        return str;
    }
}*/