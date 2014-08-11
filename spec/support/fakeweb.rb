require 'fakeweb'
FakeWeb.allow_net_connect = false

def fake_post(path, response, code=nil)
  FakeWeb.register_uri(
    :post,
    "https://pi.pardot.com#{path}",
    { :body => response, :status => [(code||=200),'']})
end

def fake_get(path, response, code=nil)
  FakeWeb.register_uri(
    :get,
    "https://pi.pardot.com#{path}",
    { :body => response, :status => [(code||=200),'']})
end

def fake_authenticate(client, api_key)
  client.api_key = api_key
end
