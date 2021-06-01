This repo is for Skedulo tech test, it includes:
Task 1:
- Approval process                   : force-app\main\default\approvalProcesses\Contact.Contact_Approve.approvalProcess-meta.xml
- Automatically send approve request : force-app\main\default\triggers\AutomaticSendApproveRequest.trigger
- Increment Total_Contact            : force-app\main\default\triggers\increaseTotalContactWhenCreatingContact.trigger
- Decrement when delete Contact      : force-app\main\default\triggers\decreaseTotalContactWhenCreatingContact.trigger

Task 2:
- Visualforce page : force-app\main\default\pages\Search_Account_And_Contact.page
- Controller       : force-app\main\default\classes\SearchAccountContactController.cls

Task 3:
- Visualforce page : force-app\main\default\pages\IncrementPage.page
- Controller       : force-app\main\default\classes\IncrementController.cls

Task 4:
- Rest handler : force-app\main\default\classes\RestUpdateContacts.cls
- Unittest     : force-app\main\default\classes\ContactUpdateTest.cls
