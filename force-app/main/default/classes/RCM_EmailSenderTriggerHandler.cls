/**
* @author Fumiyasu Tanaka
* @date 11/05/2019
* @description
* Class sends confirmation emails with the specified template to the candidates whenever they are choosen as employees.
*/
public class RCM_EmailSenderTriggerHandler {
    static final String EMAIL_TEMPLATE_NAME = 'Candidate_Confirmation_Email';
    static final Integer MIN_NUMBER_SEND_EMAIL = 1;

    /**
    * @author Fumiyasu Tanaka
    * @date 11/05/2019
    * @description
	* This method sends confirmation emails with the specified template to the candidates who are chosen as employees
	* when new records of RCM_Job_Application__c are created.
    * @param triggerNew EmailSendTrigger's Trigger.New
    * @return void
    */
    public static void beforeInsert(List<RCM_Job_Application__c> triggerNew) {
        List < Messaging.SingleEmailMessage > emailList = new List < Messaging.SingleEmailMessage > ();
        //Get Template
        EmailTemplate emailTemplate = [
            SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = : EMAIL_TEMPLATE_NAME
        ];

        for (RCM_Job_Application__c jacNew : triggerNew) {
            System.debug('RCM_Job_Application__c.RCM_Status__c :' + jacNew.RCM_Status__c);

            if (jacNew.RCM_Status__c == 'Hired') {
                //Get Candidate Fields
                RCM_Candidate__c candidate = [
                    SELECT Id, RCM_Email__c, RCM_First_Name__c FROM RCM_Candidate__c WHERE id = : jacNew.RCM_Candidate__c LIMIT 1
                ];
                System.debug('RCM_Candidate__c candidate:' + candidate);

                //Create Email and Add Email to emailList
                emailList.add(createEmail(emailTemplate, candidate));
            }

            //Send Email
            if (MIN_NUMBER_SEND_EMAIL <= emailList.size()) {
                try {
                    Messaging.sendEmail(emailList);
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 11/05/2019
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
        List < Messaging.SingleEmailMessage > emailList = new List < Messaging.SingleEmailMessage > ();
        //Get Template
        EmailTemplate emailTemplate = [
            SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = : EMAIL_TEMPLATE_NAME
        ];

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

                //Create Email and Add Email to emailList
                emailList.add(createEmail(emailTemplate, candidate));
            }

            //Send Email
            if (MIN_NUMBER_SEND_EMAIL <= emailList.size()) {
                try {
                    Messaging.sendEmail(emailList);
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 11/05/2019
    * @description
	* This method create confirmation emails with the specified template.
    * @param emailTemplate The specified template
    * @param candidate Candidate who are chosen as employees
    * @return void
    */
    private static Messaging.SingleEmailMessage createEmail(
        EmailTemplate emailTemplate,
        RCM_Candidate__c candidate
    ) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        String[] toAddresses = new String[]{candidate.RCM_Email__c};
        email.setToAddresses(toAddresses);
        email.setSenderDisplayName('Salesforce');
        email.setSubject(emailTemplate.Subject);
        email.setBccSender(false);
        email.setUseSignature(false);
        email.setPlainTextBody(
            'Dear ' + candidate.RCM_First_Name__c + '\n\n' + emailTemplate.Body
        );
        System.debug('Email :' + email);

        return email;
    }

}