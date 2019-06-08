/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_DoublePositionTriggerHander Class.
*/
@isTest
private class RCM_DoublePositionTriggerHanderTest {

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when new record is inserted. 
    */
    @isTest static void TestNormalCase01InsertOneRecord(){
        //Create Position Data
        RCM_Position__c position = new RCM_Position__c(Name='UnitTest');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(position, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when some new records are inserted. 
    */
    @isTest static void TestNormalCase02InsertMultiRecord(){
        try{
            //Create Multi Position Data
            RCM_Position__c position01 = new RCM_Position__c(Name='UnitTest01');
            RCM_Position__c position02= new RCM_Position__c(Name='UnitTest02');
            RCM_Position__c[] positionList = new RCM_Position__c[]{position01,position02};
            
            Test.startTest();
 	        insert positionList;
 			Test.stopTest();
            
            System.assert(true);
         } catch (Exception e) {
            System.assert(false);
         }
	}
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when one record is updated. 
    */    
    @isTest static void TestNormalCase03UpdateOneRecord(){
        //Create Position Data
        RCM_Position__c position = new RCM_Position__c(Name='UnitTest');
        insert position;
        position.Name='UnitTest For Update';

        Test.startTest();
        Database.SaveResult result = Database.update(position, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when some records are updated. 
    */    
    @isTest static void TestNormalCase04UpdateMultiRecord(){
        try{
            //Create Multi Position Data
            RCM_Position__c position01 = new RCM_Position__c(Name='UnitTest01');
            RCM_Position__c position02= new RCM_Position__c(Name='UnitTest02');
            RCM_Position__c[] positionList = new RCM_Position__c[]{position01,position02};
 	        insert positionList;
			
            positionList[0].Name += ' For Update';
            positionList[1].Name += ' For Update';
            
            Test.startTest();
 	        update positionList;
 			Test.stopTest();
            
            System.assert(true);
         } catch (Exception e) {
            System.assert(false);
         }
     }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when new record is inserted, its name is the same as other one. 
    */
    @isTest static void TestAbnormalCase01InsertOneRecord(){
        //Create Position Data
        RCM_Position__c positionTest = new RCM_Position__c(Name='UnitTest01');
		insert positionTest;
         
        try{
            RCM_Position__c position = new RCM_Position__c(Name='UnitTest01');
        	Test.startTest();
            insert position;
            Test.stopTest();
            
            System.assert(false);
         } catch (Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please Input Unique Position Name.') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
         }
         
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when some new records are inserted, their names are the same. 
    */
    @isTest static void TestAbnormalCase02InsertMultiRecord(){
        try{
            //Create Multi Position Data
            RCM_Position__c position01 = new RCM_Position__c(Name='UnitTest');
            RCM_Position__c position02= new RCM_Position__c(Name='UnitTest');
            RCM_Position__c[] positionList = new RCM_Position__c[]{position01,position02};
            
 	        insert positionList;
 
            System.assert(false);
         } catch (Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please Input Unique Position Name.') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
         }
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when one record is updated, its name is the same as other one. 
    */   
    @isTest static void TestAbnormalCase03UpdateOneRecord(){
        //Create Position Data
        RCM_Position__c position01 = new RCM_Position__c(Name='UnitTest01');
        RCM_Position__c position02 = new RCM_Position__c(Name='UnitTest02');
        RCM_Position__c[] positionList = new RCM_Position__c[]{position01,position02};
 	    insert positionList;
        
        RCM_Position__c position = [SELECT Id FROM RCM_Position__c WHERE Name='UnitTest01' Limit 1];
        
        try{
            position.Name = 'UnitTest02';
        	Test.startTest();
            update position;
            Test.stopTest();
            
            System.assert(false);
         } catch (Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please Input Unique Position Name.') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
         }
         
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionTriggerHander when some records are updated, their name are the same. 
    */   
    @isTest static void TestAbnormalCase02ByUpdateMultiRecord(){
        //Create Multi Position Data
        RCM_Position__c position01 = new RCM_Position__c(Name='UnitTest01');
        RCM_Position__c position02= new RCM_Position__c(Name='UnitTest02');
        RCM_Position__c[] positionList = new RCM_Position__c[]{position01,position02};            
        insert positionList;
        
        try{
			positionList[0].Name = 'UnitTest';
			positionList[1].Name = 'UnitTest';
            update positionList;
 
            System.assert(false);
         } catch (Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('Please Input Unique Position Name.') ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
         }
    }
    
}