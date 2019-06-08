/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_DoublePositionsTrigger Class.
*/
@isTest
private class RCM_DoublePositionsTriggerTest {

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify RCM_DoublePositionsTrigger when new record is inserted. 
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
    * This method is to verify RCM_DoublePositionsTrigger when one record is updated. 
    */
    @isTest static void TestNormalCase02UpdateOneRecord(){
        //Create Position Data
        RCM_Position__c position = new RCM_Position__c(Name='UnitTest');
		insert position;
        
        position.Name = 'UpdatedUnitTest';
        
        Test.startTest();
        Database.SaveResult result = Database.update(position, false);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
    }
}