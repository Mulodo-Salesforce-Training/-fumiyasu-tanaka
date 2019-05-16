/**
* @author Fumiyasu Tanaka
* @date 16/05/2019
* @description
* Class sends confirmation emails with the specified template to the candidates whenever they are choosen as employees.
*/
public class RCM_EmailSenderTriggerHandler {
    static final String EMAIL_TEMPLATE_NAME = 'Candidate_Confirmation_Email';

    /**
    * @author Fumiyasu Tanaka
    * @date 16/05/2019
    * @description
	* This method sends confirmation emails with the specified template to the candidates who are chosen as employees
	* when new records of RCM_Job_Application__c are created.
    * @param triggerNew EmailSendTrigger's Trigger.New
    * @return void
    */
    public static void beforeInsert(List<RCM_Job_Application__c> triggerNew) {
        //Get Template
        EmailTemplate emailTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = : EMAIL_TEMPLATE_NAME];
        //Get Contact
        Contact contact = [SELECT Id, Email FROM Contact Limit 1];

        for (RCM_Job_Application__c jacNew : triggerNew) {
            System.debug('RCM_Job_Application__c.RCM_Status__c :' + jacNew.RCM_Status__c);

            if (jacNew.RCM_Status__c == 'Hired') {
                //Get Candidate Fields
                RCM_Candidate__c candidate = [
                    SELECT Id, RCM_Email__c, RCM_First_Name__c FROM RCM_Candidate__c WHERE id = : jacNew.RCM_Candidate__c LIMIT 1
                ];
                System.debug('RCM_Candidate__c candidate:' + candidate);

                //Create Email
                Messaging.SingleEmailMessage mail = createEmail(
                    emailTemplate,
                    candidate,
                    contact
                );

                //Send Email
                try {
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 16/05/2019
    * @description
	* This method sends confirmation emails with the specified template to the candidates who are chosen as employees
	* when the existing records of RCM_Job_Application__c are updated.
    * @param triggerNew EmailSendTrigger's Trigger.New
    * @param triggerOldMap EmailSendTrigger's Trigger.OldMap
    * @return void
    */
    public static void beforeUpdate(
        List<RCM_Job_Application__c> triggerNew,
        Map<Id, RCM_Job_Application__c> triggerOldMap
    ) {
        //Get Template
        EmailTemplate emailTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = : EMAIL_TEMPLATE_NAME];
        //Get Contact
        Contact contact = [SELECT Id, Email FROM Contact Limit 1];

        for (RCM_Job_Application__c jacNew : triggerNew) {
            RCM_Job_Application__c jacOld = triggerOldMap.get(jacNew.Id);
            System.debug(
                'NEW RCM_Job_Application__c.RCM_Status__c :' + jacNew.RCM_Status__c
            );
            System.debug(
                'OLD RCM_Job_Application__c.RCM_Status__c :' + jacOld.RCM_Status__c
            );

            if (jacNew.RCM_Status__c != jacOld.RCM_Status__c && jacNew.RCM_Status__c == 'Hired') {
                //Get Candidate Fields
                RCM_Candidate__c candidate = [
                    SELECT Id, RCM_Email__c, RCM_First_Name__c FROM RCM_Candidate__c WHERE id = : jacNew.RCM_Candidate__c LIMIT 1
                ];
                System.debug('RCM_Candidate__c candidate:' + candidate);

                //Create Email
                Messaging.SingleEmailMessage mail = createEmail(
                    emailTemplate,
                    candidate,
                    contact
                );

                //Send Email
                try {
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 16/05/2019
    * @description
	* This method create confirmation emails with the specified template.
    * @param emailTemplate The specified template
    * @param candidate Candidate who are chosen as employees
    * @param contact Contact for TargetObjectId
    * @return void
    */
    private static Messaging.SingleEmailMessage createEmail(
        EmailTemplate emailTemplate,
        RCM_Candidate__c candidate,
        Contact contact
    ) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        String[] toAddresses = new String[]{candidate.RCM_Email__c};
        email.setTemplateId(emailTemplate.Id);
        email.setTargetObjectId(contact.Id);
        email.setWhatId(candidate.Id);
        email.setUseSignature(false);
        email.setBccSender(false);
        email.setSaveAsActivity(false);
        email.setToAddresses(toAddresses);
        email.setSenderDisplayName('Salesforce');
        System.debug('Email :' + email);

        return email;
    }

}