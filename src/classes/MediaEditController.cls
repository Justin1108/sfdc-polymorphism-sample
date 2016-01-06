public with sharing class MediaEditController {
    private final Media__c media;
    private Audio__c audio;
    private Image__c image;
    private Video__c video;

    public MediaEditController(ApexPages.StandardController controller) {
        this.media = (Media__c)controller.getRecord();

        if (this.media.media_type__c == null)
            this.media.media_type__c = 'Image';

        if (this.media.media_type__c == 'Audio')
            this.audio = new Audio__c(Media__c = this.media.Id);
        else if (this.media.media_type__c == 'Image')
            this.image = new Image__c(Media__c = this.media.Id);
        else if (this.media.media_type__c == 'Video')
            this.video = new Video__c(Media__c = this.media.Id);

    }

    public PageReference selectMediaType() {
        this.audio = null;
        this.image = null;
        this.video = null;
        
        if (this.media.media_type__c == 'Audio')
            this.audio = new Audio__c(Media__c = this.media.Id);
        else if (this.media.media_type__c == 'Image')
            this.image = new Image__c(Media__c = this.media.Id);
        else if (this.media.media_type__c == 'Video')
            this.video = new Video__c(Media__c = this.media.Id);

        return null;
    }
    
    public Audio__c getAudio() {
        return this.audio;
    }
    
    public Video__c getVideo() {
        return this.video;
    }
    
    public Image__c getImage() {
        return this.image;
    }
    
    public PageReference save() {
        media.Name = 'Media name';
        insert media;
    
        if (this.media.media_type__c == 'Audio') {
            this.audio.Media__c = this.media.Id;
            insert this.audio;
        } else if (this.media.media_type__c == 'Image') {
            this.image.Media__c = this.media.Id;
            insert this.image;
        } else if (this.media.media_type__c == 'Video') {
            this.video.Media__c = this.media.Id;
            insert this.video;
        }
        
        PageReference mPage = new ApexPages.StandardController(media).view();

        mPage.setRedirect(true);

        return mPage;
    }

}