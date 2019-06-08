@isTest
global class MockHttpResponseCoordinateWeather implements HttpCalloutMock {
    
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String resBody ='';
        String resHeaderCT ='';
        if (req.getEndpoint().contains('https://www.geocoding.jp/api/?q=')) {
        	System.assertEquals('GET', req.getMethod());
        	resBody = '<result><coordinate><lat>10.784774</lat><lng>106.684622</lng><lat_dms>10,47,5.187</lat_dms><lng_dms>106,41,4.638</lng_dms></coordinate></result>';
			resHeaderCT = 'application/xml';
        } else if (req.getEndpoint().contains('https://api.openweathermap.org/data/2.5/weather')) {
        	System.assertEquals('GET', req.getMethod());
			resBody = '{"coord":{"lon":135.5,"lat":34.7},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":302.15,"pressure":1012,"humidity":38,"temp_min":298.15,"temp_max":306.48},"visibility":10000,"wind":{"speed":2.6,"deg":250},"clouds":{"all":75},"dt":1559796150,"sys":{"type":1,"id":8032,"message":0.0055,"country":"JP","sunrise":1559763909,"sunset":1559815693},"timezone":32400,"id":1853909,"name":"Osaka","cod":200}';
			resHeaderCT = 'application/json';
        } else {
            System.assert(false, 'API Endpoint is Wrong');
        }
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', resHeaderCT);
		res.setBody(resBody);
        res.setStatusCode(200);
        return res;
    }

}