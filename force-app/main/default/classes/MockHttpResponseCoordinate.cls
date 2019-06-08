@isTest
global class MockHttpResponseCoordinate implements HttpCalloutMock {
    private String resBody;
    
    public MockHttpResponseCoordinate (String resBody) {
		this.resBody = resBody;
	}
    
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assert(req.getEndpoint().contains('https://www.geocoding.jp/api/?q='));
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/xml');
        res.setBody(resBody);
        res.setStatusCode(200);
        return res;
    }

}