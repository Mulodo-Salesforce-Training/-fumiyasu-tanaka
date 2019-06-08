/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_EmailSenderTrigger Class.
*/
@isTest
private class RCM_EmailSenderTriggerTest {
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is setup method. It creates a new contact. 
    */
	@testSetup static void setup() {
        //Create Contact Data
        Contact contact = new Contact(LastName='UnitTest');
		insert contact;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_EmailSenderTrigger when new record is inserted. 
    */
	@isTest static void TestNormalCase01InsertOneRecord(){
        //Create Candidate Data
        RCM_Candidate__c candidate = new RCM_Candidate__c(RCM_First_Name__c='UnitTest', RCM_Last_Name__c='Candidate', RCM_Phone__c='01234567890', RCM_Email__c='fumiyasu.tanaka@mulodo.com');
		insert candidate;
        //Create Position Data
        RCM_Position__c position = new RCM_Position__c(Name='UnitTest');
		insert position;
        
        //Create Job Appilcation Data        
        RCM_Job_Application__c ja = new RCM_Job_Application__c(RCM_Candidate__c=candidate.Id, RCM_Position__c=position.Id, RCM_status__c='New');

        Test.startTest();
        Database.SaveResult result = Database.insert(ja, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_EmailSenderTrigger when one record is updated. 
    */
    @isTest static void TestNormalCase02UpdateOneRecord(){
        //Create Candidate Data
        RCM_Candidate__c candidate = new RCM_Candidate__c(RCM_First_Name__c='UnitTest', RCM_Last_Name__c='Candidate', RCM_Phone__c='01234567890', RCM_Email__c='fumiyasu.tanaka@mulodo.com');
		insert candidate;
        //Create Position Data
        RCM_Position__c position = new RCM_Position__c(Name='UnitTest');
		insert position;        
        //Create Job Appilcation Data 
        RCM_Job_Application__c ja = new RCM_Job_Application__c(RCM_Candidate__c=candidate.Id, RCM_Position__c=position.Id, RCM_status__c='New');
		insert ja;
        
        ja.RCM_Status__c = 'Review Resume';
        
        Test.startTest();
        Database.SaveResult result = Database.update(ja, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }

}