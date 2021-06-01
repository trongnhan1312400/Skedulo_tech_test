trigger increaseTotalContactWhenCreatingContact on Contact (after update) {
    Contact contact = Trigger.New[0];
    List<Account> accounts = [SELECT Id,Total_Contacts__c FROM Account 
                              WHERE Id=:contact.AccountId];

    for (Account account: accounts) {
        account.Total_Contacts__c = account.Total_Contacts__c + 1;
    }
    
    update accounts;
}