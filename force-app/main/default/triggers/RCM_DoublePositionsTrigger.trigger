trigger RCM_DoublePositionsTrigger on RCM_Position__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            RCM_DoublePositionsTriggerHander.beforeInsert(Trigger.New);
        }
        else if (Trigger.isUpdate) {
            RCM_DoublePositionsTriggerHander.beforeUpdate(Trigger.New,Trigger.Old);
        }
    }
}
