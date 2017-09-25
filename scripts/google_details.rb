require 'json'
require 'pry'
require 'firebase'
require 'faraday'
require 'dotenv'

base_uri = 'https://philly-bucketlist.firebaseio.com/'
firebase = Firebase::Client.new(base_uri, "AIzaSyBZqJh7r6POY_WaoyzrLAaghv-_K_Q7EvA")

conn = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/place/textsearch/json')

item_hash = JSON.parse(IO.read('list.json'))

item_hash['items'].each { |item|

	result = conn.get do |req|
		req.params['query'] = item['address']
		req.params['key'] = 'AIzaSyAj6HfqrKdKF1bXBiskKl3SV24PI8XJjIY'
	end

	result_json = JSON.parse(result.body)

	binding.pry
	response = firebase.push("items", { :name => item['name'], :google_data => result_json })
}








response.success? # => true
response.code # => 200
response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'