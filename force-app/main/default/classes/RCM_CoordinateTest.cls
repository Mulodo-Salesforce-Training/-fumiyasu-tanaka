/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_Coordinate Class.
*/
@isTest
private class RCM_CoordinateTest {

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setCoordinate() method when API returns a coordinate info. 
    */
    @isTest static void TestNormalCase01SetCoordinate() {
		RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_Street__c ='111D Ly Chinh Thang';
        candidate.RCM_City__c ='Ho Chi Minh City';
        candidate.RCM_Postal_Code__c ='700000';
        candidate.RCM_Country__c ='Vietnam';
		RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.setAddress(candidate);
         
         // Set mock callout class
        String resBody = '<result><coordinate><lat>10.784774</lat><lng>106.684622</lng><lat_dms>10,47,5.187</lat_dms><lng_dms>106,41,4.638</lng_dms></coordinate></result>';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseCoordinate(resBody));
                
        Test.startTest();
        coordinate.setCoordinate();
        Test.stopTest();
         
        System.assert(coordinate.lat == 10.784774);
        System.assert(coordinate.lng == 106.684622);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setCoordinate() method when API doesn't return a coordinate info. 
    */
    @isTest static void TestNormalCase02SetCoordinate() {
		RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_Street__c ='111D Ly Chinh Thang';
        candidate.RCM_City__c ='Ho Chi Minh City';
        candidate.RCM_Postal_Code__c ='700000';
        candidate.RCM_Country__c ='Vietnam';
		RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.setAddress(candidate);
         
         // Set mock callout class
        String resBody = '<result></result>';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseCoordinate(resBody));
                
        Test.startTest();
        coordinate.setCoordinate();
        Test.stopTest();
         
        System.assert(coordinate.lat == null);
        System.assert(coordinate.lng == null);
    }

    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setAddress() and getAddress() method when there is no candidate's address info. 
    */
    @isTest static void TestNormalCase03SetAddressGetAddress(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.setAddress(candidate);
        String address = coordinate.getAddress();
				
        System.assertEquals('', address);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setAddress() and getAddress() method when there is a candidate's address info. 
    */
    @isTest static void TestNormalCase04SetAddressGetAddress(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_Street__c ='111D Ly Chinh Thang';
        candidate.RCM_City__c ='Ho Chi Minh City';
        candidate.RCM_State__c ='N/A';
        candidate.RCM_Postal_Code__c ='700000';
        candidate.RCM_Country__c ='Vietnam';
        
        String expectedAddress = candidate.RCM_Street__c + ',' + candidate.RCM_City__c + ',' + candidate.RCM_State__c + ',' + candidate.RCM_Postal_Code__c + ',' + candidate.RCM_Country__c;
        
        RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.setAddress(candidate);
        String resultAddress = coordinate.getAddress();
				
        System.assert(expectedAddress == resultAddress);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify replaceAddress() method. 
    */
    @isTest static void TestNormalCase05ReplaceAddress(){
        RCM_Candidate__c candidate = new RCM_Candidate__c();
        candidate.RCM_Street__c ='111D Ly Chinh Thang';
        candidate.RCM_City__c ='Ho Chi Minh City';
        candidate.RCM_State__c ='N/A　';
        candidate.RCM_Postal_Code__c ='700000';
        candidate.RCM_Country__c ='Vietnam';
        
        String expectedAddress = candidate.RCM_Street__c + ',' + candidate.RCM_City__c + ',' + candidate.RCM_State__c + ',' + candidate.RCM_Postal_Code__c + ',' + candidate.RCM_Country__c;
        expectedAddress = expectedAddress.replace(' ', '+'); // replace full-width space
        expectedAddress = expectedAddress.replace('　', '+'); // replace half-width space
        expectedAddress = expectedAddress.replace(',', '%2C'); // replace comma       
        
        RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.setAddress(candidate);
        coordinate.replaceAddress();
				
        System.assertEquals(expectedAddress, coordinate.addressReplace);
    }

}