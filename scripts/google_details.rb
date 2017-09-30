require 'json'
require 'pry'
require 'firebase'
require 'faraday'
require 'dotenv'
Dotenv.load

base_uri = 'https://philly-bucketlist.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)

places_conn = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/place/textsearch/json')
details_conn = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/place/details/json')

item_hash = JSON.parse(IO.read('list.json'))

item_hash['items'].each { |item|

	places_result = places_conn.get do |req|
		req.params['key'] = ENV['GOOGLE_KEY']
		req.params['query'] = item['address']	
	end

	places_json = JSON.parse(places_result.body)

	details_result = details_conn.get do |req|
		req.params['key'] = ENV['GOOGLE_KEY']
		req.params['placeid'] = places_json['results'][0]['place_id']
	end

	details_json = JSON.parse(details_result.body)

	response = firebase.push("items", { :name => item['name'], :place_data => places_json['results'], :details_data => details_json['result'] })
}