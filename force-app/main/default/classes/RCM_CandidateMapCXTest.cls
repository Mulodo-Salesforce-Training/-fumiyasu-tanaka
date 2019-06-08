/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_CandidateMapCX Class.
*/
@isTest
private class RCM_CandidateMapCXTest {
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify all methods when the specified candidate data exist. 
    */
    @isTest static void TestNormalCase01All(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_First_Name__c = 'FName';
        candidate.RCM_Last_Name__c = 'LName';
        candidate.RCM_Phone__c = '01234567890';
        candidate.RCM_Email__c = 'test@test.com'; 
        candidate.RCM_Street__c ='111D Ly Chinh Thang';
        candidate.RCM_City__c ='Ho Chi Minh City';
        candidate.RCM_State__c ='N/A';
        candidate.RCM_Postal_Code__c ='700000';
        candidate.RCM_Country__c ='Vietnam';
        insert candidate;
		
        PageReference pageRef = Page.RCM_CandidateMapPage;
        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
		Test.setCurrentPage(pageRef);
        
        String resBody = '<result><coordinate><lat>10.784774</lat><lng>106.684622</lng><lat_dms>10,47,5.187</lat_dms><lng_dms>106,41,4.638</lng_dms></coordinate></result>';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseCoordinate(resBody));

        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        
        Test.startTest();
        RCM_CandidateMapCX candidateMapCX = new RCM_CandidateMapCX(sc);
        Double resultLng = candidateMapCX.getLng();
        Double resultLat = candidateMapCX.getLat();
        String resultAddress = candidateMapCX.getAddress() ;
        Test.stopTest();
        
        String expectedAddress = candidate.RCM_Street__c + ',' + candidate.RCM_City__c + ',' + candidate.RCM_State__c + ',' + candidate.RCM_Postal_Code__c + ',' +  candidate.RCM_Country__c; 
        
        System.assert(resultLng == 106.684622);
        System.assert(resultLat == 10.784774);
        System.assert(resultAddress == expectedAddress);
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify all methods when the specified candidate data don't exist. 
    */
    @isTest static void TestNormalCase02All(){		
        PageReference pageRef = Page.RCM_CandidateMapPage;
		Test.setCurrentPage(pageRef);

        RCM_Candidate__c candidate = new RCM_Candidate__c();
        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);

        Test.startTest();
        RCM_CandidateMapCX candidateMapCX = new RCM_CandidateMapCX(sc);
        Double lng = candidateMapCX.getLng();
        Double lat = candidateMapCX.getLat();
        String address = candidateMapCX.getAddress();
        Test.stopTest();

        System.assert(lng == null);
        System.assert(lat == null);
        System.assertEquals('Cannot Find the Place', address);
    }
    
}