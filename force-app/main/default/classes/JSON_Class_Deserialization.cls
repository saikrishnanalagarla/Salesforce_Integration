public with sharing class JSON_Class_Deserialization {

    public static void deserializeMethod(){
        String jsonString = '{"firstName":"John","lastName":"Doe","email":"john.doe@example.com","phone":"1234567890"}';

        // Deserialize the JSON string into an instance of ContactInfo
        Contact contact = (Contact) JSON.deserialize(jsonString, Contact.class);
        insert contact;

        // Use the deserialized object
        System.debug('First Name: ' + contact.firstName);
        System.debug('Last Name: ' + contact.lastName);
        System.debug('Email: ' + contact.email);
        System.debug('Phone: ' + contact.phone);
    }
    // Method to demonstrate the use of JSON.deserializeStrict
    public static void deserializeStrictMethod(){
        // JSON string to be deserialized
        String jsonString = '{"firstName": "John", "lastName": "Doe", "email": "john.doe@example.com", "Industry": "Education", "Name":"Sai"}';
         // Deserializing JSON string into Contact class instance strictly
        try {
            Contact contact = (Contact) JSON.deserializeStrict(jsonString, Contact.class);
            insert contact;
            Account account = (Account) JSON.deserializeStrict(jsonString, Account.class);
            insert account;
            // Debugging to check the output in the logs
            System.debug('Contact info: First Name: ' + contact.firstName + ', Last Name: ' + contact.lastName + ', Email: ' + contact.email);
        } catch (Exception e) {
             // Handling potential errors during JSON deserialization
            System.debug('Error: ' + e.getMessage());
        }
    }
    public static void deserializeUntypedMethod(){

        String jsonString = '{"firstName": "kim", "lastName": "canady", "email": "kim@example.com", "Industry": "Education", "Name":"Sai"}';
        Map<String,Object> mapdata = (MAP<String, Object>)JSON.deserializeUntyped(jsonString);
        System.debug(mapdata.keySet());
        System.debug(mapdata.values());

        // Creating a new Contact object and setting fields from JSON
        Contact con = new Contact();
        con.FirstName = (String) mapdata.get('firstName');
        con.LastName = (String) mapdata.get('lastName');
        con.Email = (String) mapdata.get('email');
        insert con;

         // Creating a new Account object and setting fields from JSON
        Account acc = new Account();
        acc.Name =(String) mapdata.get('Name');
        acc.Industry = (String) mapData.get('Industry');
        insert acc;
        // Debugging to verify values
        System.debug('Contact Details: ' + con);
        System.debug('Account Details: ' + acc); 
    }
} 