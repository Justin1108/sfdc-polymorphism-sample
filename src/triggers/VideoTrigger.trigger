trigger VideoTrigger on Video__c (before insert, after insert, before update, after delete) {
	if (Trigger.isInsert) 
        MediaTriggerHandler.processInsert();
    else if (Trigger.isUpdate) 
        MediaTriggerHandler.processUpdate();
    else if (Trigger.isDelete)
        MediaTriggerHandler.processDelete();
}