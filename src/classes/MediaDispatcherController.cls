public class MediaDispatcherController {
    private final Media__c media;

    public MediaDispatcherController(ApexPages.StandardController controller) {
        this.media= [SELECT Child_Id__c FROM Media__c WHERE Id=:controller.getRecord().id];
    }

    public PageReference dispatchView() {
        return dispatch('View');
    }
    
    public PageReference dispatchEdit() {
        return dispatch('Edit');
    }
    
    private PageReference dispatch(string request) {
        
        PageReference pageRef = null;
        if (request == 'Edit')
            pageRef = new PageReference('/' + media.Child_Id__c + '/e');
        else
            pageRef = new PageReference('/' + media.Child_Id__c);

        // Restore the return URL
        Map<String, String> params = ApexPages.currentPage().getParameters();
        for (String key : params.keySet()) {
            if (key != 'id' && key != 'sfdc.override')
                pageRef.getParameters().put(key, params.get(key));
        }
        
        return pageRef;
    }

}