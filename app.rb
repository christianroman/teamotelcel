require 'sinatra'
require 'json'
require 'httparty'
require 'rubygems'
require 'builder'
require 'open-uri'

ENDPOINT = 'http://movil2.speedymovil.com.mx/perfils/autenticar/#phone.json'

get '/' do
  erb :index
end

post '/info' do
  phone = params[:phone]
  string_url = ENDPOINT.gsub('#phone', phone)
  response = HTTParty.get(string_url)
  json = JSON.parse(response.body)
  password = json["nip"]
  if !password.nil?
    query = {
      password: password
    }
    response = HTTParty.get(string_url, :query => query)
    json = JSON.parse(response.body)
    @items = json
    erb :info
  end
end
