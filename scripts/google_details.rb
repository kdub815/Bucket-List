require 'json'
require 'pry'
require 'firebase'
require 'faraday'
require 'dotenv'
Dotenv.load

base_uri = 'https://philly-bucketlist.firebaseio.com/'
firebase = Firebase::Client.new(base_uri)

conn = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/place/textsearch/json')

item_hash = JSON.parse(IO.read('list.json'))

item_hash['items'].each { |item|

	result = conn.get do |req|
		req.params['key'] = ENV['GOOGLE_KEY']
		req.params['query'] = item['address']	
	end

	result_json = JSON.parse(result.body)

	response = firebase.push("items", { :name => item['name'], :google_data => result_json['results'] })
}