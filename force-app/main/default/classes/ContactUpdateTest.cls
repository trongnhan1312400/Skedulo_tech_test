@IsTest
public class ContactUpdateTest {
	@istest
    static void testUpdateContacts() {
        String newLastname = 'TestUpdate';
        Id testContactId = createRecord();
        Map<String, Object> valid = new Map<String, Object>();
        valid.put('Id', testContactId);
        valid.put('LastName', newLastname);
        
        Map<String, Object> lackingId = new Map<String, Object>();
        lackingId.put('LastName', 'sample');
        
        Map<String, Object> nonexistContact = new Map<String, Object>();
        nonexistContact.put('Id', '0015g012d0Et000000');
        nonexistContact.put('LastName', 'sample');
        
        List<Map<String, Object>> data = new List<Map<String, Object>>();
        data.add(valid);
        data.add(lackingId);
        data.add(nonexistContact);
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://dek-dev-ed.lightning.force.com/services/apexrest/Contacts';
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(JSON.serialize(data));
        
        RestContext.request = request;
        String result = RestUpdateContacts.updateContacts();
        system.debug(result);
        system.assert(result.contains('Record does not exist!'));
        system.assert(result.contains('Missing required field Id'));
    }
    
    static ID createRecord() {
        Contact c = new Contact(LastName='Test1', FirstName='Test1');
        insert c;
        return c.Id;
    }
}