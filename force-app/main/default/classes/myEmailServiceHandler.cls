global class myEmailServiceHandler implements Messaging.InboundEmailHandler 
{
 
  global Messaging.InboundEmailResult  handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env)
{
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    
    // Store the email plain text into the local variable 
    myPlainText = email.plainTextBody;
   
    // Create a new Contact object 
    Contact[] newContact = new Contact[0];
   
    // Try to look up any contacts based on the from email address.
    // If there are more than one contacts with the same email address,
    // an exception will be thrown and the catch statement block will be executed.
try 
{      
      // Add a new Task to the contact record we just found above.
      newContact.add(new Contact(lastname = 'email service demo' , Description =  myPlainText,
           subjects__c = email.subject));
     
     // Insert the new Task 
     insert newContact;    
     
     System.debug(' newContact Object: '+newContact);   
    }
    // If an exception occurs when the query accesses 
    // the contact record, a QueryException is thrown.
    // The exception is written to the Apex debug log.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}