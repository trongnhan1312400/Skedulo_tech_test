trigger decreaseTotalContactWhenCreatingContact on Contact (before delete) {
    Contact contact = Trigger.Old[0];
    if (contact.Active__c == True) {
        List<Account> accounts = [SELECT Id,Total_Contacts__c FROM Account 
                                  WHERE Id=:contact.AccountId];
    
        for (Account account: accounts) {
            account.Total_Contacts__c = account.Total_Contacts__c - 1;
        }
        
        update accounts;
    }
}