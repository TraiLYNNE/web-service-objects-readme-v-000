class FoursquareService
    
    def authenticate!(client_id, client_secret, code)
        resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
            req.params['client_id'] = client_id
            req.params['client_secret'] = client_secret
            req.params['grant_type'] = 'authorization_code'
            req.params['redirect_uri'] = "https://trailynne-trailynne.c9users.io/auth"
            req.params['code'] = code
        end
        body = JSON.parse(resp.body)
        body["access_token"]
    end
    
    def friends(token)
        resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
           req.params['oauth_token'] = token
           req.params['v'] = '20170707'
        end
        
        JSON.parse(resp.body)["response"]["friends"]["items"]
    end
    
    def foursquare(client_id, client_secret, near)
        resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
            req.params['client_id'] = client_id
            req.params['client_secret'] = client_secret
            req.params['v'] = '20160201'
            req.params['near'] = params[:zipcode]
            req.params['query'] = 'coffee shop'
        end
      
        JSON.parse(resp.body)["response"]["venues"]
    end
    
    def tips(token)
        resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
            req.params['oauth_token'] = token
            req.params['v'] = '20170707'
        end
        
        JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
    end
    
    def create_tip(token, venue_id, text)
        Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
            req.params['oauth_token'] = token
            req.params['v'] = '20160201'
            req.params['venueId'] = venue_id
            req.params['text'] = text
        end
    end
  
end