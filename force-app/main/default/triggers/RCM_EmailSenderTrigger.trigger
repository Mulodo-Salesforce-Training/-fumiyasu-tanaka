trigger RCM_EmailSenderTrigger on RCM_Job_Application__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            RCM_EmailSenderTriggerHandler.beforeInsert(Trigger.New);
        }
        if (Trigger.isUpdate) {
            RCM_EmailSenderTriggerHandler.beforeUpdate(Trigger.New,Trigger.OldMap);
        }
    }
}
