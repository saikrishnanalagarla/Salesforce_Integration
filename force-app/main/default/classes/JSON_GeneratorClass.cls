public with sharing class JSON_GeneratorClass {
    
    // JSON TO APEX
     // Method for creating an account and generating a JSON response
    public static String generatorMethod(String name ,String industry , String phone){

       JSONGenerator jsGenerator = JSON.createGenerator(true);
        jsGenerator.writeStartObject();
        try {
        Account acc =new Account();
        acc.Name = name;
        acc.Industry = industry;
        acc.Phone = phone;
        insert acc;
      // Sending a success response
        jsGenerator.writeStringField('Status','Success');
        jsGenerator.writeIdField('AccountId',acc.Id );
        jsGenerator.writeNumberField('Code', 201);
        }catch(Exception e){
          // Catching exceptions, logging, and writing error to JSON output
          System.debug('Error while inserting account: ' + e.getMessage());
          jsGenerator.writeStringField('Status', 'Account failed to create');
          jsGenerator.writeStringField('Error', e.getMessage());
        }
        jsGenerator.writeEndObject();
        String result = jsGenerator.getAsString();
        System.debug(result);  // Optionally log the JSON output for debugging
        return result;  // Return the JSON string as output
    }
    //APEX TO JSON
    //sending deatils to 3rd party system
    public static String apextoJson() {
        JSONGenerator jsGenerator = JSON.createGenerator(true);
        jsGenerator.writeStartObject();
        try {
            // Querying accounts with non-null phone numbers
            List<Account> accList = [SELECT Id, Name, Phone, Industry FROM Account WHERE Phone != null];
            
            // Initiate array for multiple accounts
            jsGenerator.writeFieldName('Accounts');
            jsGenerator.writeStartArray();
            
            for (Account acc : accList) {
                // Start an object for each account
                jsGenerator.writeStartObject();
                
                jsGenerator.writeStringField('Name', acc.Name);
                jsGenerator.writeStringField('Phone', acc.Phone);
                jsGenerator.writeStringField('Industry', acc.Industry);
                jsGenerator.writeStringField('Status', 'Success');
                
                // Close each account object
                jsGenerator.writeEndObject();
            }
            
            // End the array of accounts
            jsGenerator.writeEndArray();
        } catch (Exception e) {
            System.debug('Error while processing accounts to JSON: ' + e.getMessage());
            // Handle exception by noting failure at the end of JSON, only if no accounts were processed
            jsGenerator.writeStringField('Status', 'Failed');
            jsGenerator.writeStringField('Error', e.getMessage());
        }
    
        // Close the overall JSON object
        jsGenerator.writeEndObject();
        String json = jsGenerator.getAsString();
        System.debug(json);
        return json;
    }
    
}