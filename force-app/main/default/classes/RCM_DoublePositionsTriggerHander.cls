/**
* @author Fumiyasu Tanaka
* @date 17/05/2019
* @description
* Class checks and fires error message for "Double Position" when creating/editing positions.
*/
public class RCM_DoublePositionsTriggerHander {
    static final Integer MIN_NUMBER_SAME_NAME_DATA = 1;

    /**
    * @author Fumiyasu Tanaka
    * @date 17/05/2019
    * @description
	* This method checks and fires error message for "Double Position" when creating positions.
    * @param triggerNew RCM_DoublePositionsTrigger's Trigger.New
    * @return void
    */
    public static void beforeInsert(List<RCM_Position__c> triggerNew) {
        for (RCM_Position__c pc : triggerNew) {
            // Compare Data on Database
            Integer countSameNameData = [SELECT count()FROM RCM_Position__c WHERE Name = : pc.Name];
            System.debug('countSameNameData :' + countSameNameData);
            System.debug('pc.Id :' + pc.Id);
            System.debug('pc.Name :' + pc.Name);

            if (countSameNameData >= MIN_NUMBER_SAME_NAME_DATA) {
                pc.addError('Please Input Unique Position Name.');
            }

            // Compare Data in Trigger.New
            Integer countSameNameNewData = 0;
            for (RCM_Position__c pcNew : triggerNew) {
                if (pc.Name == pcNew.Name && pc.Id != pcNew.Id) {
                    countSameNameNewData++;
                }
            }

            if (countSameNameNewData >= MIN_NUMBER_SAME_NAME_DATA) {
                pc.addError('Please Input Unique Position Name.');
            }

        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 17/05/2019
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
        for (RCM_Position__c pc : triggerNew) {

            // Compare Data Except Trigger.Old (on Database)
            Integer countSameNameData = [SELECT count()FROM RCM_Position__c WHERE Name = : pc.Name AND Id NOT IN: triggerOld];
            System.debug('countSameNameData :' + countSameNameData);
            System.debug('pc.Id :' + pc.Id);
            System.debug('pc.Name :' + pc.Name);

            if (countSameNameData >= MIN_NUMBER_SAME_NAME_DATA) {
                pc.addError('Please Input Unique Position Name.');
            }

            // Compare Data in Trigger.New
            Integer countSameNameNewData = 0;
            for (RCM_Position__c pcNew : triggerNew) {
                if (pc.Name == pcNew.Name && pc.Id != pcNew.Id) {
                    countSameNameNewData++;
                }
            }

            if (countSameNameNewData >= MIN_NUMBER_SAME_NAME_DATA) {
                pc.addError('Please Input Unique Position Name.');
            }

        }
    }

}