/**
* @author Fumiyasu Tanaka
* @date 21/05/2019
* @description
* Class checks and fires error message for "Double Position" when creating/editing positions.
*/
public class RCM_DoublePositionsTriggerHander {

    /**
    * @author Fumiyasu Tanaka
    * @date 21/05/2019
    * @description
	* This method checks and fires error message for "Double Position" when creating positions.
    * @param triggerNew RCM_DoublePositionsTrigger's Trigger.New
    * @return void
    */
    public static void beforeInsert(List<RCM_Position__c> triggerNew) {
        List<RCM_Position__c> positionDBList = [SELECT Name FROM RCM_Position__c];

        for (RCM_Position__c pc : triggerNew) {
            // Compare Data on Database
            for (RCM_Position__c positionDB : positionDBList) {
                if (positionDB.Name == pc.Name) {
                    pc.addError('Please Input Unique Position Name.');
                }
            }

            // Compare Data in Trigger.New
            for (RCM_Position__c pcNew : triggerNew) {
                if (pc.Name == pcNew.Name && pc.Id != pcNew.Id) {
                    pc.addError('Please Input Unique Position Name.');
                }
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 21/05/2019
    * @description
	* This method checks and fires error message for "Double Position" when updating positions.
    * @param triggerNew RCM_DoublePositionsTrigger's Trigger.New
    * @param triggerOld RCM_DoublePositionsTrigger's Trigger.Old
    * @return void
    */
    public static void beforeUpdate(
        List<RCM_Position__c> triggerNew,
        List<RCM_Position__c> triggerOld
    ) {
        List<RCM_Position__c> positionDBList = [SELECT Name FROM RCM_Position__c WHERE Id NOT IN: triggerOld];

        for (RCM_Position__c pc : triggerNew) {
            // Compare Data Except Trigger.Old (on Database)
            for (RCM_Position__c positionDB : positionDBList) {
                if (positionDB.Name == pc.Name) {
                    pc.addError('Please Input Unique Position Name.');
                }
            }

            // Compare Data in Trigger.New
            for (RCM_Position__c pcNew : triggerNew) {
                if (pc.Name == pcNew.Name && pc.Id != pcNew.Id) {
                    pc.addError('Please Input Unique Position Name.');
                }
            }

        }
    }

}