public class AccountWebService {
    
    @AuraEnabled(cacheable=true)
    public static String makeGetCallout() {
       
         Http http = new Http();
         HttpRequest request = new HttpRequest();       
         //request.setEndpoint('callout:Org2000New/services/apexrest/Accounts/?accName='+ Name);
         request.setEndpoint('callout:Integration10/services/apexrest/Accounts/');

         request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        
       /* String jsonInput = '{\n' +
            ' "a" : "0015i00000LIrBSAA1",\n'+
            ' "name" : "MadhavGR"\n}';
            
        request.setBody(jsonInput);*/
         HttpResponse response = http.send(request);
          System.debug(response);
         System.debug(response.getBody());
        
      

        return response.getBody();
}
    
    @AuraEnabled(cacheable=true)
    public static void makePostCallout(String body){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Org2000New/services/apexrest/Accounts/');
         request.setMethod('POST');
         request.setHeader('Content-Type', 'application/json');            
          request.setBody(body);
         HttpResponse response = http.send(request);
        System.debug(response);
         System.debug(response.getBody());
       
    }
     @AuraEnabled(cacheable=true)
    public static void makePatchCallout(String body){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Org2000New/services/apexrest/Accounts/');
         request.setMethod('PATCH');
         request.setHeader('Content-Type', 'application/json');            
          request.setBody(body);
         HttpResponse response = http.send(request);
        System.debug(response);
         System.debug(response.getBody());
       
    }
     @AuraEnabled(cacheable=true)
    public static String makePutCallout(String Name,String body){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Org2000New/services/apexrest/Accounts/?accName='+Name);
         request.setMethod('PUT');
         request.setHeader('Content-Type', 'application/json');            
          request.setBody(body);
         HttpResponse response = http.send(request);
        System.debug(response);
         System.debug(response.getBody());
       return response.getBody();
    }
    @AuraEnabled(cacheable=true)
    public static String makeDeleteCallout(String AccId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Org2000New/services/apexrest/Accounts/?accId='+ AccId);
         request.setMethod('DELETE');
         request.setHeader('Content-Type', 'application/json');            
          //request.setBody();
         HttpResponse response = http.send(request);
        System.debug(response);
        // System.debug(response.getBody());
       return null;
    }
}