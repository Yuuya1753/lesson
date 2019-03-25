require 'sinatra'
require 'httpclient'

post "/homework32/alc" do

	content_type :json
	base_url = 'https://eow.alc.co.jp/search'

	client = HTTPClient.new()
	# client.debug_dev = STDOUT
	result = {}
	params[:words].each_line { |word|
		query = {}
		query["q"] = word
		query["ref"] = "sa"
		res = client.get(base_url, query)
		search_result = res.body[/<span class="midashi(.*?)<\/div>/m]

		result[word] = search_result
	}
	result.to_json

end