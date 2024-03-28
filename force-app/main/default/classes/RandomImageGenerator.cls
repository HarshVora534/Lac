public with sharing class RandomImageGenerator {
        @future(callout=true)
        public static void makeCallout(){
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.unsplash.com/photos/random/oauth/authorize');
            req.setMethod('GET');
            HTTPResponse res=http.send(req);
            if(res.getStatusCode() == 200)
            {
                System.debug(res.getBody());
            }
            else {
                System.debug('ERROR');
            }
        }
}