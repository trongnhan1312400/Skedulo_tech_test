trigger AutomaticSendApproveRequest on Contact (after insert) {
    for (Contact contact: Trigger.New) {
        Approval.ProcessSubmitRequest approvalRequest = new Approval.ProcessSubmitRequest();
        approvalRequest.setComments('Contact Submitted for approval');
        approvalRequest.setObjectId(contact.Id);
        Approval.ProcessResult approvalResult = Approval.process(approvalRequest);
        System.debug('offer submitted for approval successfully: '+approvalResult .isSuccess());
    }
}