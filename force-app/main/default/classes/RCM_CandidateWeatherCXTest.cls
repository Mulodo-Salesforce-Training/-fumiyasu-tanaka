/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_CandidateWeatherCX Class.
*/
@isTest
private class RCM_CandidateWeatherCXTest {

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify all methods when the specified candidate exists. 
    */
	@isTest(SeeAllData=true)
    static void TestNormalCase01All(){
        RCM_Candidate__c candidate = [SELECT Id FROM RCM_Candidate__c Limit 1];
		
        PageReference pageRef = Page.RCM_CandidateWeatherPage;
        if (candidate != null) {
	        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
        }
		Test.setCurrentPage(pageRef);

        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseCoordinateWeather());
		RCM_CandidateWeatherCX candidateWeatherCX = new RCM_CandidateWeatherCX(sc);

        Test.startTest();
        RCM_Candidate__c resultCandidate = candidateWeatherCX.getCandidate();
        Integer resultId =  candidateWeatherCX.getId();
        String resultMain =  candidateWeatherCX.getMain();
        String resultDescription =  candidateWeatherCX.getDescription();
        String resultIcon = candidateWeatherCX.getIcon();
        Test.stopTest();

        if (candidate != null) {
            System.assertEquals(candidate.Id, resultCandidate.Id);
            System.assert(resultId == 803);
            System.assert(resultMain == 'Clouds');
            System.assert(resultDescription == 'broken clouds');
            System.assert(resultIcon == '04d');
        } else {
            System.assert(resultCandidate == null);
            System.assert(resultId == null);
            System.assert(resultMain == null);
            System.assert(resultDescription == null);
            System.assert(resultIcon == null);
        }        
        
    }
    
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify all methods when the specified candidate doesn't exist. 
    */
	@isTest static void TestNormalCase02All(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
		
        PageReference pageRef = Page.RCM_CandidateWeatherPage;
        pageRef.getParameters().put('id', String.valueOf(candidate.Id));
		Test.setCurrentPage(pageRef);

        Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(candidate);
        RCM_CandidateWeatherCX candidateWeatherCX = new RCM_CandidateWeatherCX(sc);
		
        Test.startTest();
        RCM_Candidate__c resultCandidate = candidateWeatherCX.getCandidate();
        Integer resultId =  candidateWeatherCX.getId();
        String resultMain =  candidateWeatherCX.getMain();
        String resultDescription =  candidateWeatherCX.getDescription();
        String resultIcon = candidateWeatherCX.getIcon();
        Test.stopTest();

        System.assert(resultCandidate == null);
        System.assert(resultId == null);
        System.assert(resultMain == null);
        System.assert(resultDescription == null);
        System.assert(resultIcon == null);
    }


}