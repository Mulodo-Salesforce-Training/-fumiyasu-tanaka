/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_CandidateRegistrationCX Class.
*/
@isTest
private class RCM_CandidateRegistrationCXTest {

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify getCandidate() method when RCM_CandidateRegistrationNewPage is displayed. 
    */
    @isTest static void TestNormalCase01GetCandidate(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);

        Test.startTest(); 
		RCM_Candidate__c resultCandidate = candidateRegCX.getCandidate();
        Test.stopTest();
        
        System.assertEquals(null, resultCandidate.Id);
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify getCandidate() method when RCM_CandidateRegistrationEditPage is opened. 
    */    
    @isTest static void TestNormalCase02GetCandidate(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
        insert candidate;
		
        PageReference pageRef = Page.RCM_CandidateRegistrationEditPage;
        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
		Test.setCurrentPage(pageRef);
        
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
        
		Test.startTest(); 
        RCM_Candidate__c resultCandidate = candidateRegCX.getCandidate();
        Test.stopTest();
        
        System.assertEquals(candidate.Id, resultCandidate.Id);
    }    

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify save() method without picture in RCM_CandidateRegistrationNewPage. 
    */    
    @isTest static void TestNormalCase03SaveWithoutPicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.save();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify saveAndNew() method without picture in RCM_CandidateRegistrationNewPage. 
    */    
    @isTest static void TestNormalCase04SaveAndNewWithoutPicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.saveAndNew();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify save() method with picture in RCM_CandidateRegistrationNewPage. 
    */    
    @isTest static void TestNormalCase05SaveWithPicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
		candidateRegCX.Picture = blob.toPdf('This is a test string');

        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.save();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify saveAndNew() method with picture in RCM_CandidateRegistrationNewPage. 
    */    
    @isTest static void TestNormalCase06SaveAndNewWithPicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
		candidateRegCX.Picture = blob.toPdf('This is a test string');

        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.saveAndNew();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify save() method with updated picture in RCM_CandidateRegistrationEditPage. 
    */    
    @isTest static void TestNormalCase07SaveWithUpdatePicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
        insert candidate;
		
	    Attachment attachment = new Attachment();    
        attachment.Body = blob.toPdf('This is a existing string');
        attachment.Name = 'RCM_ProfilePicture.jpg';
        attachment.Parentid= candidate.Id;
        attachment.ContentType = 'application/pdf';
        insert attachment;

        PageReference pageRef = Page.RCM_CandidateRegistrationEditPage;
        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
		Test.setCurrentPage(pageRef);
        
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);

        System.assertEquals(candidateRegCX.candidate.Id , candidate.Id);

        candidateRegCX.candidate = candidate;
		candidateRegCX.Picture = blob.toPdf('This is a update string');

        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.save();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verity saveAndNew() method with updated picture in RCM_CandidateRegistrationEditPage. 
    */    
    @isTest static void TestNormalCase08SaveAndNewWithUpdatePicture(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com';        
        insert candidate;
        
        Attachment attachment = new Attachment();    
        attachment.Body = blob.toPdf('This is a existing string');
        attachment.Name = 'RCM_ProfilePicture.jpg';
        attachment.Parentid= candidate.Id;
        attachment.ContentType = 'application/pdf';
        insert attachment;
		
        PageReference pageRef = Page.RCM_CandidateRegistrationEditPage;
        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
		Test.setCurrentPage(pageRef);

        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
		candidateRegCX.Picture = blob.toPdf('This is a update string');

        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.saveAndNew();
        Test.stopTest();

		System.assertEquals('https://ap6.salesforce.com/' + candidateRegCX.candidate.Id , resultPageRef.getUrl(), 'Passed Unit Test');
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify save() method when exception is thown.
    */    
    @isTest static void TestAbnormalCase01Save(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;
        
        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.save();
        Test.stopTest();

		System.assert(resultPageRef == null);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify saveAndNew() method when exception is thown.
    */    
    @isTest static void TestAbnormalCase02SaveAndNew(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
		
        PageReference pageRef = Page.RCM_CandidateRegistrationNewPage;
		Test.setCurrentPage(pageRef);
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateRegistrationCX candidateRegCX = new RCM_CandidateRegistrationCX(sc);
		
        candidateRegCX.candidate = candidate;

        Test.startTest();
        Pagereference resultPageRef = candidateRegCX.saveAndNew();
        Test.stopTest();
        
		System.assert(resultPageRef == null);
    }
    
}