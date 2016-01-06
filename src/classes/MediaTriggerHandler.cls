public class MediaTriggerHandler {
    public static void processInsert() {
        if (Trigger.isBefore) {
            // Process records whose parent Media__c is not set
            Map<integer, Media__c> mediaIdxMap = new Map<integer, Media__c>();
            for (integer i = 0; i < Trigger.New.size(); i++) {
                if (Trigger.New[i].get('Media__c') == null) {
                    Media__c m = new Media__c(Name = 'To be updated...');
                    mediaIdxMap.put(i, m);
                }
            }
            insert mediaIdxMap.values();
            for (integer idx : mediaIdxMap.keySet()) {
                Trigger.New[idx].put('Media__c', mediaIdxMap.get(idx).Id); 
            }
        } else {
            // isAfter
            updateParentFields(Trigger.New, true);
        }
    }
    public static void processUpdate() {
        if (Trigger.isBefore) {
            updateParentFields(Trigger.New, false);
        }
    }
    
    public static void processDelete() {
        if (Trigger.isAfter) {
            List<Media__c> objsToDel = new List<Media__c>();
            for (SObject media : Trigger.Old) {
                objsToDel.add(new Media__c(Id = (ID)media.get('Media__c')));
            }
            delete objsToDel;
        }
    }
    
    public static void updateParentFields(List<SObject> childObjs, boolean isNew) {
        List<Media__c> objsToUpdate = new List<Media__c>();
        for (integer i = 0; i < childObjs.size(); i++) {
            // Sync name field value to parent Media__c object
            Media__c parent = new Media__c(Id = (ID)childObjs[i].get('Media__c'),
                                           Name = (String)childObjs[i].get('Name'));
            
            if (isNew) {
                // Create the Parent to Child link reference
                parent.Child_Id__c = childObjs[i].Id;   
                //parent.Media_Type__c = childObjs[i].getSObjectType().getDescribe().getLabel();
            }
            objsToUpdate.add(parent);
        }
        update objsToUpdate;
    }
}