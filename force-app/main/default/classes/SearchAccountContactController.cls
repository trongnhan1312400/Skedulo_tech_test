public class SearchAccountContactController {
    public class Result {
        public String recordType {get;set;}
        public String recordName {get;set;}
        public String recordId {get;set;}
        
        public Result(String recordType, String recordName, String recordId) {
            this.recordType = recordType;
            this.recordName = recordName;
            this.recordId = recordId;
        }
    }
    public String searchKey {get;set;}
    public List<Result> result {get;set;}
    
    public SearchAccountContactController() {
        this.result = new List<Result>();
    }
    
    public void search() {
        this.result.clear();
        String searchString = '%' + this.searchKey + '%';
        List<Account> accounts = [SELECT Name,Id FROM Account
                                  WHERE Name LIKE : searchString];
        for (Account account: accounts) {
            this.result.add(new Result('Account', account.Name, account.Id));
        }
        
        List<Contact> contacts = [SELECT Name,Id FROM Contact
                                  WHERE Name LIKE : searchString];
        for (Contact contact: contacts) {
            this.result.add(new Result('Contact', contact.Name, contact.Id));
        }
    }
}