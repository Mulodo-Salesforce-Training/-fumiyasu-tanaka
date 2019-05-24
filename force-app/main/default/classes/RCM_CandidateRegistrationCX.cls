/**
* @author Fumiyasu Tanaka
* @date 24/05/2019
* @description
* This Class is VF Controller Extension for RCM_CandidateRegistrationNewPage and RCM_CandidateRegistrationEditPage.
*  It allow users to input the candidate's information and upload the candidate's profile picture with its methods on the VF pages.
*/
public class RCM_CandidateRegistrationCX {
    private final String HOST_NAME = 'https://ap6.salesforce.com/';
    private final String PAGE_NAME = 'apex/RCM_CandidateRegistrationNewPage';
    private final String ATTACHMENT_PATH = '/servlet/servlet.FileDownload?file=';
    private final String ATTACHMENT_NAME = 'RCM_ProfilePicture.jpg';
    private final String ATTACHMENT_CONTENT_TYPE = 'application/jpg';
    private final RCM_Candidate__c candidate;
    public blob Picture {
        get;
        set;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 24/05/2019
    * @description
    * This method is the constructor of this class and initialize candidate.
    * @param ApexPages.StandardController Starndard Controller of the VF pages
    */
    public RCM_CandidateRegistrationCX(ApexPages.StandardController stdController) {
        RCM_Candidate__c[] candidateList = [
            SELECT Id,
            RCM_First_Name__c,
            RCM_Last_Name__c,
            RCM_Phone__c,
            RCM_Birthday__c,
            RCM_Email__c,
            RCM_Street__c,
            RCM_State__c,
            RCM_City__c,
            RCM_Postal_Code__c,
            RCM_Country__c,
            RCM_Currently_Employed__c,
            RCM_Years_of_Experience__c,
            RCM_Current_Company__c,
            RCM_Education__c,
            Owner.Name,
            Name,
            RCM_Picture_Url__c 
            FROM RCM_Candidate__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')
        ];
        if (candidateList.size() > 0) {
            candidate = candidateList[0];
        } else {
            candidate = new RCM_Candidate__c();
        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 24/05/2019
    * @description
    * This method is getter for candidate.
    */
    public RCM_Candidate__c getCandidate() {
        return candidate;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 24/05/2019
    * @description
    * This method is save process for candidate and attachment.
    * When save process is successful, it navigates Candidate Detail Screen.
    */
    public PageReference save() {
        PageReference pageRef = null;
        try {
            upsert candidate;

            if (picture != null) {
                Attachment attachment = createAttachment();
                String attId = attachment.Id;
                String attachmentId = attId.substring(0, 15);
                candidate.RCM_Picture_Url__c = ATTACHMENT_PATH + attachmentId;
                update candidate;
            }

            pageRef = new PageReference(HOST_NAME + candidate.Id);
        } catch (DmlException e) {
            ApexPages.addMessages(e);
        }

        return pageRef;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 20/05/2019
    * @description
    * This method is save process for candidate and attachment.
    * When save process is successful, it navigates new Candidate Registration Screen.
    */
    public PageReference saveAndNew() {
        PageReference pageRef = null;
        try {
            upsert candidate;

            if (picture != null) {
                Attachment attachment = createAttachment();
                String attId = attachment.Id;
                String attachmentId = attId.substring(0, 15);
                candidate.RCM_Picture_Url__c = ATTACHMENT_PATH + attachmentId;
                update candidate;
            }

            pageRef = new PageReference(HOST_NAME + candidate.Id);
        } catch (DmlException e) {
            ApexPages.addMessages(e);
        }

        return pageRef;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 20/05/2019
    * @description
    * This method creates/updates an Attachment for Candidate's Profile Picture.
    * @return Attachment attachment for Candidate's Profile Picture
    */
    private Attachment createAttachment() {
        Attachment attachment;
        List<Attachment> attachmentList = [
            SELECT Id, Name, Body FROM Attachment WHERE Name = : ATTACHMENT_NAME AND ParentId = : candidate.Id
        ];

        If(attachmentList.size() > 0) {
            attachment = attachmentList[0];
            attachment.Body = picture;
            update attachment;
        } else {
            attachment = new Attachment();
            attachment.Body = picture;
            attachment.Name = ATTACHMENT_NAME;
            attachment.Parentid = candidate.Id;
            attachment.ContentType = ATTACHMENT_CONTENT_TYPE;
            insert attachment;
        }

        return attachment;
    }
}