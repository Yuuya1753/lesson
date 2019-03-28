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
		# p res.body
		search_result = res.body[/<span class="midashi(.*?)<\/div>/m]
		# p search_result[1]
		if search_result != nil
			result[word] = search_result.split("\n", 2)[1]
		else
			result[word] = "<div>語訳の取得に失敗しました。</div>"
		end
	}
	result.to_json

end