/**
* @author Fumiyasu Tanaka
* @date 31/05/2019
* @description 
* This Class is VF Controller Extension for RCM_CandidateMapPage.
* It uses RCM_Coordinate Class to get the coordinate of the candidate's address with API (https://www.geocoding.jp/api/) 
* and show the map of the coordinate on the VF page.
*/
public class RCM_CandidateMapCX {
    private final RCM_Candidate__c candidate;
    private RCM_Coordinate coordinate;

    /**
    * @author Fumiyasu Tanaka
    * @date 31/05/2019
    * @description 
    * This method is the constructor of this class 
    * and initialize candidate and candidate's coordinate. 
    * @param ApexPages.StandardController Starndard Controller of the VF pages
    */
    public RCM_CandidateMapCX(ApexPages.StandardController stdController) {
        RCM_Candidate__c[] candidateList 
            = [SELECT Id, RCM_Street__c, RCM_State__c, RCM_City__c, RCM_Postal_Code__c, RCM_Country__c
               FROM RCM_Candidate__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];

        coordinate = new RCM_Coordinate();
        if (candidateList.size() > 0) {
            candidate = candidateList[0];
            coordinate.setAddress(candidate);
            coordinate.setCoordinate();
        } else {
            candidate = null;
        }
    }    

    /**
    * @author Fumiyasu Tanaka
    * @date 31/05/2019
    * @description 
    * This method is getter for the longitude of candidate's address.
    */    
    public Double getLng() {
        return coordinate.lng;            
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 31/05/2019
    * @description 
    * This method is getter for the latitude of candidate's address.
    */    
    public Double getLat() {
        return coordinate.lat;            
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 31/05/2019
    * @description 
    * This method is getter for the candidate's address.
    */    
    public String getAddress() {
        if (coordinate.lng == null || coordinate.lat == null) {
            return 'Cannot Find the Place';
        }
        return coordinate.getAddress();
    }
    
}