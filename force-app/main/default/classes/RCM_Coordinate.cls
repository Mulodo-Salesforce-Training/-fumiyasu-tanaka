/**
* @author Fumiyasu Tanaka
* @date 28/05/2019
* @description
* This Class gets a coordinate with Geocoding API(https://www.geocoding.jp/api/) by candiate's address.
*/
public class RCM_Coordinate {
    private final String API = 'https://www.geocoding.jp/api/';
    private final String QUERY_ADDRESS = '?q=';
    @TestVisible private String addressReplace;
	private String address;
    public Double lat;
    public Double lng;

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method gets a coordinate with Geocoding API by candiate's address.
    */
    public void setCoordinate() {
        //Define http Request append your Query to the base url
        HttpRequest req = new HttpRequest();
        replaceAddress();
        req.setEndpoint(API + QUERY_ADDRESS + addressReplace);
        req.setMethod('GET');

        //Get Response
        Http http = new Http();
        HTTPresponse res = http.send(req);

        Dom.Document resDoc = res.getBodyDocument();
        Dom.XmlNode Root = resDoc.getRootElement();
        String resDocString = resDoc.toXmlString();

        if (resDocString.contains('coordinate')) {
            this.lat = double.valueOf(
                Root.getChildElement('coordinate', null).getChildElement('lat', null).getText()
            );
            this.lng = double.valueOf(
                Root.getChildElement('coordinate', null).getChildElement('lng', null).getText()
            );
        } else {
            this.lat = null;
            this.lng = null;
        }

    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method is getter for candiate's address.
    */
    public String getAddress() {
        return this.address;
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method is setter for candiate's address.
    * @param  RCM_Candidate__c candidate
    */
    public void setAddress(RCM_Candidate__c candidate) {
        address = '';
        if (!(candidate.RCM_Street__c == NULL)) {
            address = address + candidate.RCM_Street__c + ',';
        }

        if (!(candidate.RCM_City__c == NULL)) {
            address = address + candidate.RCM_City__c + ',';
        }

        if (!(candidate.RCM_State__c == NULL)) {
            address = address + candidate.RCM_State__c + ',';
        }

        if (!(candidate.RCM_Postal_Code__c == NULL)) {
            address = address + candidate.RCM_Postal_Code__c + ',';
        }

        if (!(candidate.RCM_Country__c == NULL)) {
            address = address + candidate.RCM_Country__c;
        }
    }

    /**
    * @author Fumiyasu Tanaka
    * @date 28/05/2019
    * @description
    * This method replaces some characters for API query.
    */
    @TestVisible private void replaceAddress() {
        addressReplace = address;
        addressReplace = addressReplace.replace(' ', '+'); // replace full-width space
        addressReplace = addressReplace.replace('　', '+'); // replace half-width space
        addressReplace = addressReplace.replace(',', '%2C'); // replace comma
    }

}