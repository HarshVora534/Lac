public class GoogleMapComponent {
    public static void GoogleMapComponent() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://maps.googleapis.com/maps/api/js?key=AIzaSyDmxa0XmQaxvLCOOdc0rUhzUxEEbSPgtJs&callback=initMap');
        req.setMethod('GET');
        try{
            HTTPResponse res = http.send(req);
            if(res.getStatusCode() == 200)
            {
                System.debug('Success!!');
            }
            else{
                System.debug('Error fetching details');
            }
        }
        catch(Exception e)
        {
            System.debug(e.getMessage());
        }
    }
}