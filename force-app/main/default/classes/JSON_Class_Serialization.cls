public with sharing class JSON_Class_Serialization {
   
    public static List<Account> serializeMethod(String industry){
       // This example shows how to serialize a simple integer to JSON, but it is not used later in the code.
        Integer num = 10;
        String jsonNum = JSON.serialize(num);

        // Querying a list of accounts from the database where the industry matches the provided parameter
        List<Account> listAcc = [SELECT ID ,Name ,Phone, Industry FROM Account WHERE Industry =:Industry LIMIT 10];

         // Serializing the list of accounts to a JSON string
        String jsonAccList = JSON.serialize(listAcc);
        System.debug('Serialized Account List: ' + jsonAccList);
        return listAcc;
    }
}