/**
* @author Fumiyasu Tanaka
* @date 28/05/2019
* @description 
* This Class is VF Controller Extension for RCM_CandidateWeatherPage.
* It uses RCM_WeatherEx Class to get weather information of the candidate with API (https://openweathermap.org/current) 
* and passes the information to the VF page.
*/
public class RCM_CandidateWeatherCX {
    private final RCM_Candidate__c candidate;
    private RCM_WeatherEx  weatherEx;
    private RCM_Coordinate coordinate;

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is the constructor of this class 
    * and initialize candidate, candidate's coordinate and weather info. 
    * @param ApexPages.StandardController Starndard Controller of the VF pages
    */
    public RCM_CandidateWeatherCX(ApexPages.StandardController stdController) {
        RCM_Candidate__c[] candidateList
            = [SELECT Id, RCM_Street__c, RCM_State__c, RCM_City__c, RCM_Postal_Code__c, RCM_Country__c
               FROM RCM_Candidate__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        
        weatherEx = new RCM_WeatherEx();
        coordinate = new RCM_Coordinate();
        if (candidateList.size() > 0) {
			candidate = candidateList[0];
            coordinate.setAddress(candidate);
            coordinate.setCoordinate();
            weatherEx.setCoordinate(coordinate);
            weatherEx.setWeather();
        } else {
            candidate = null;
        }
    }
    
    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is getter for candidate.
    */
    public RCM_Candidate__c getCandidate() {
	    return candidate;
    }
        
    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is getter for Id of weather info.
    */
    public Integer getId () {
    	return weatherEx.Id;    
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is getter for Main of weather info.
    */
    public String getMain() { 
    	return weatherEx.Main;    
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is getter for Description of weather info.
    */
    public String getDescription() { 
    	return weatherEx.Description;    
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description 
    * This method is getter for Icon of weather info.
    */
    public String getIcon() {
    	return weatherEx.Icon;    
    }

}