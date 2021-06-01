@RestResource(urlMapping='/Contacts')
global with sharing class RestUpdateContacts {
    global static Map<String, Object> createError(Object obj, String message) {
        Map<String, Object> error = new Map<String, Object>();
        error.put('success', false);
        error.put('error', message);
        error.put('withData', obj);
        return error;
    }
    
    global static Map<String, Object> createSuccess(Object obj) {
        Map<String, Object> success = new Map<String, Object>();
        success.put('success', true);
        success.put('withData', obj);
        return success;
    }
    
	@HttpPatch
    global static String updateContacts() {
        RestRequest request = RestContext.request;
		List<Object> temp = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<Map<String, Object>> contacts = new List<Map<String, Object>>();
        for (Object o: temp) {
            contacts.add((Map<String, Object>)o);
        }
        Map<String, Map<String, Object>> mapValidContacts = new Map<String, Map<String, Object>>();
        List<Map<String, Object>> results = new List<Map<String, Object>>();
        List<Map<String, Object>> validRecords = new List<Map<String, Object>>(); 

        for (Map<String, Object> contact: contacts) {
            if (!contact.keySet().contains('Id')) {
              	results.add(createError(contact, 'Missing required field Id'));
            }
            else {
                mapValidContacts.put((String)contact.get('Id'), contact);
            }
        }
        
        List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Id IN: mapValidContacts.keySet()];
        
        for (Contact contact: existingContacts) {
            String contactId = contact.Id;
            if (mapValidContacts.keySet().contains(contactId)) {
                Map<String, Object> c = mapValidContacts.get(contactId);
                mapValidContacts.remove(contactId);
                for (String field: c.keySet()) {
                    if (field != 'Id') {
                        contact.put(field, c.get(field));
                    }
                }
                results.add(createSuccess(c));
            }
        }
        
        Database.update(existingContacts);
        
        for (String k: mapValidContacts.keySet()) {
            results.add(createError(mapValidContacts.get(k), 'Record does not exist!'));
        }

        return JSON.serialize(results);
    }
}