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
		if search_result != nil
			result[word] = search_result.split("\n", 2)[1]
		else
			result[word] = "<div>語訳の取得に失敗しました。</div>"
		end
	}
	result.to_json

end

post "/homework32/sanseido" do

	content_type :json
	base_url = 'https://www.sanseido.biz/User/Dic/Index.aspx'

	client = HTTPClient.new()
	# client.debug_dev = STDOUT
	result = {}
	params[:words].each_line { |word|
		query = {}
		query["TWords"] = word
		# 検索でヒットしないため、
		# 1単語なのかどうかで検索方法を変更する
		# 例：flowerは前方一致検索、shooting starは全文検索
		if word.split.length == 1
			query["st"] = "0"
		else
			query["st"] = "3"
		end
		query["DORDER"] = ""
		query["DailyEJ"] = "checkbox"
		query["DailyJE"] = "checkbox"

		res = client.get(base_url, query)
		search_result = res.body[/<div class="NetDicBody(.*?)<\/div>/m]
		if search_result != nil
			result[word] = search_result
		else
			result[word] = "<div>語訳の取得に失敗しました。</div>"
		end
	}
	result.to_json

end

post "/homework32/nifty" do

	content_type :json
	base_url = 'http://dictionary.nifty.com/'

	client = HTTPClient.new()
	# client.debug_dev = STDOUT
	result = {}
	params[:words].each_line { |word|
		# 日本語が含まれるか
		if word !~ /\p{Hiragana}|\p{Katakana}|[一-龠々]/
			url = base_url + "ejword/"
		else
			url = base_url + "jeword/"
		end

		if word.split.length == 1
			url = url + word.chomp
		else
			words = word.split
			url_word = ""
			words.length.times { |i|
				if i == 0
					url_word = words[i]
				else
					url_word = url_word + "+" + words[i]
				end
			}
			url = url + url_word
		end

		res = client.get(url)
		search_result = res.body[/<div class="word_block">(.*?)ありません。\n\n          <\/div>/m]
		if search_result != nil
			search_result.slice!(/<p class="word_copy">(.*?)ありません。\n\n          /m)
			result[word] = search_result
		else
			result[word] = "<div>語訳の取得に失敗しました。</div>"
		end
	}
	result.to_json

end