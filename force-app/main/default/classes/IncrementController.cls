public class IncrementController {
	public class Result {
        public String recordType {get;set;}
        public String recordName {get;set;}
        public Decimal count {get;set;}
        public String recordId {get;set;}
        
        public Result(String recordType, String recordName, Decimal count, String recordId) {
            this.recordType = recordType;
            this.recordName = recordName;
            this.count = count;
            this.recordId = recordId;
        }
    }
    public String searchKey {get;set;}
    public List<Result> result {get;set;}
    
    public IncrementController() {
        this.result = new List<Result>();
    }
    
    public void search() {
        this.result.clear();
        if (String.isEmpty(this.searchKey)) {
            return;
        }
        String searchString = '%' + this.searchKey + '%';
        List<Account> accounts = [SELECT Name,Count__c,Id FROM Account
                                  WHERE Name LIKE : searchString];
        for (Account account: accounts) {
            this.result.add(new Result('Account', account.Name,
                                       account.Count__c, account.Id));
        }
        
        List<Contact> contacts = [SELECT Name,Count__c,Id FROM Contact
                                  WHERE Name LIKE : searchString];
        for (Contact contact: contacts) {
            this.result.add(new Result('Contact', contact.Name,
                                       contact.Count__c, contact.Id));
        }
    }
    
    public void updateCount() {
        for (Result r: this.result) {
            if (r.recordType == 'Account') {
                Account account = [SELECT Count__c,Id FROM Account
                                   WHERE Id =: r.recordId];
                r.count = account.Count__c;
            }
            else if (r.recordType == 'Contact') {
                Contact contact = [SELECT Count__c,Id FROM Contact
                                   WHERE Id =: r.recordId];
                r.count = contact.Count__c;
            }
        }
    }
    
    @RemoteAction
    public static void increaseCount(String recordId, String recordType) {
        if (recordType == 'Account') {
         	List<Account> accounts = [SELECT Count__c,Id FROM Account
                                      WHERE Id =: recordId];
            for (Account account: accounts) {
                account.Count__c = account.Count__c + 1;
            }
            Database.update(accounts);
        }
        else if (recordType == 'Contact') {
         	List<Contact> contacts = [SELECT Count__c,Id FROM Contact
                                      WHERE Id =: recordId];
            for (Contact contact: contacts) {
                contact.Count__c = contact.Count__c + 1;
            }
            Database.update(contacts);
        }
    }
}