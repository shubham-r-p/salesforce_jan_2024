public class AccountWebServiceTwo {
    
    @AuraEnabled
    public static string returnSobjects(){
        
        Http htt = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        
        req.setMethod('GET');
        req.setEndpoint('callout:Integration10/services/apexrest/returnFields/');
        req.setHeader('Content-Type', 'application/json');
        
        res = htt.send(req);
        
        system.debug('res --> '+res.getBody());
        
        return res.getBody();
    }
    
    @AuraEnabled(cacheable=true)
    public static String makePostCallout(String body){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Integration10/services/apexrest/returnFields/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        String jsonInput = '{\n'+
            				'"obj" : "'+body+'"\n}';

		request.setBody(jsonInput);
        System.debug(request);
        HttpResponse response = http.send(request);
        System.debug(response);
        system.debug('Parsed json response body'+JSON.createParser(response.getBody()));
        System.debug(response.getBody());
        
     //   List<String> lstFields = (List<String>) JSON.deserializeUntyped(response.getBody());

     //   system.debug('lstFields --> '+lstFields);
        
        return response.getBody();
    }
    
}