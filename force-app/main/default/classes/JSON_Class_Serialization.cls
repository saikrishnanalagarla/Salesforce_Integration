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

        // Query the accounts and store the results directly into a Map<Id, Account>
        Map<Id, Account> mapAcc = new Map<Id, Account>([
            SELECT Id, Name, Phone, Industry 
            FROM Account 
            WHERE Industry = 'Education' 
            LIMIT 10
        ]);
              // Serializing the Map of accounts to a JSON string
              String jsonAccMap = JSON.serialize(mapAcc);
              System.debug('Serialized Account Map: ' + mapAcc);
        // Output the map to debug log to inspect the stored values
        System.debug(mapAcc);
        return listAcc;
    }
    //Example data 
    public class Product {
        public String name;
        public Double price;
        public String description;
        public Integer stockQuantity;
    
        public Product(String name, Double price, String description, Integer stockQuantity) {
            this.name = name;
            this.price = price;
            this.description = description;
            this.stockQuantity = stockQuantity;
        }
    }    
    public static void serializesuppressApexObjectNulls(){
        // Create an instance of the Product class
        Product myProduct = new Product('Laptop', 999.99, null, 20);

        // Serialize the product to JSON, suppressing null values
        String jsonString = JSON.serialize(myProduct, true);

        // Output the JSON string
        System.debug(jsonString);
        //Output {"name":"Laptop","price":999.99,"stockQuantity":20}
    }
    public static void serializePretty(){
        //is used to convert an object into a formatted JSON string with indents and line breaks, making it more readable.
        List<Account> accounts = [SELECT Id, Name, Phone, Industry FROM Account LIMIT 5];
        String jsonString = JSON.serializePretty(accounts);
        System.debug(jsonString);

    }

}