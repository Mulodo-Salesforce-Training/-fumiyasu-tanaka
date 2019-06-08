@isTest
global class MockHttpResponseWeather implements HttpCalloutMock {    
    private String resBody;
    
    public MockHttpResponseWeather (String resBody) {
		this.resBody = resBody;
	}
    
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assert(req.getEndpoint().contains('https://api.openweathermap.org/data/2.5/weather'));
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(resBody);
        res.setStatusCode(200);
        return res;
    }
    
}