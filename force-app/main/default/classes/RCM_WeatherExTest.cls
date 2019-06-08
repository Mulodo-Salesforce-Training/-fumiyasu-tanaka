/**
* @author Fumiyasu Tanaka
* @date 07/06/2019
* @description 
* This Class is Test Class for RCM_WeatherEx Class.
*/
@isTest
private  class RCM_WeatherExTest {

        /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setWeather() method when API returns a weather info. 
    */
    @isTest static void TestNormalCase01SetWeather(){
        //Call out Test
		RCM_WeatherEx weatherEx = new RCM_WeatherEx();

        // Set mock callout class
        String resBody = '{"coord":{"lon":135.5,"lat":34.7},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":302.15,"pressure":1012,"humidity":38,"temp_min":298.15,"temp_max":306.48},"visibility":10000,"wind":{"speed":2.6,"deg":250},"clouds":{"all":75},"dt":1559796150,"sys":{"type":1,"id":8032,"message":0.0055,"country":"JP","sunrise":1559763909,"sunset":1559815693},"timezone":32400,"id":1853909,"name":"Osaka","cod":200}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseWeather(resBody));
                
        Test.startTest();
        weatherEx.setWeather();
        Test.stopTest();
         
        System.assert(weatherEx.Id == 803);
        System.assert(weatherEx.Main == 'Clouds');
        System.assert(weatherEx.Description == 'broken clouds');
        System.assert(weatherEx.Icon == '04d');
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setWeather() method when API doesn't returns a weather info. 
    */
    @isTest static void TestNormalCase02SetWeather(){
        //Call out Test
		RCM_WeatherEx weatherEx = new RCM_WeatherEx();

        // Set mock callout class
        String resBody = '{"cod":"404","message":"city not found"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseWeather(resBody));
                
        Test.startTest();
        weatherEx.setWeather();
        Test.stopTest();
         
        System.assert(weatherEx.Id == null);
        System.assert(weatherEx.Main == null);
        System.assert(weatherEx.Description == null);
        System.assert(weatherEx.Icon == null);
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 07/06/2019
    * @description
    * This method is to verify setCoordinate() method. 
    */
    @isTest static void TestNormalCase03SetCoordinate(){
        //Create Position Data
        RCM_WeatherEx weatherEx = new RCM_WeatherEx();
        RCM_Coordinate coordinate = new RCM_Coordinate();
        coordinate.lat = 0.0;
        coordinate.lng = 0.0;
        weatherEx.setCoordinate(coordinate);
		
        System.assertEquals(coordinate.lat, weatherEx.lat);
        System.assertEquals(coordinate.lng, weatherEx.lng);
    }

}