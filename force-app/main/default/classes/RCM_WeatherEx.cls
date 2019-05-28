/**
* @author Fumiyasu Tanaka
* @date 28/05/2019
* @description
* This Class sets Candidate's address coordinate
* and gets the weatehr parameters of Current weather data from OpenWeatherMap API by the coordinate.
* @extend RCM_Wether this base class
*/
public class RCM_WeatherEx extends RCM_Weather {
    private final String API = 'https://api.openweathermap.org/data/2.5/weather';
    private final String API_KEY = '&appid=e24206cc069c1e27e05a0db6ad7fc8d3';
    private final String QUERY_LAT = '?lat=';
    private final String QUERY_LON = '&lon=';
    private Double lng;
    private Double lat;

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method is to get the weatehr parameters of Current weather data from OpenWeatherMap API by Candidate's address coordinate.
    */
    public void setWeather() {
        //Define http Request append your Query to the base url
        HttpRequest req = new HttpRequest();
        req.setEndpoint(
            API + QUERY_LAT + this.lat + QUERY_LON + this.lng + API_KEY
        );
        req.setMethod('GET');

        //Get Response
        Http http = new Http();
        HTTPresponse res = http.send(req);
        String response = res.getBody();

        if (response.contains('weather')) {
            String str = response.substring(
                response.indexOf('"weather":[') + 11,
                response.indexof('],"base":')
            );
            RCM_Weather weather = (RCM_Weather)JSON.deserialize(str, RCM_Weather.class);
            this.id = weather.id;
            this.main = weather.main;
            this.description = weather.description;
            this.icon = weather.icon;
        } else {
            this.id = null;
            this.main = null;
            this.description = null;
            this.icon = null;
        }

    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method is to set Candidate's address coordinate.
    * @param RCM_Coordinate a coordinate of candidate's address
    */
    public void setCoordinate(RCM_Coordinate coordinate) {
        this.lng = coordinate.lng;
        this.lat = coordinate.lat;
    }

}