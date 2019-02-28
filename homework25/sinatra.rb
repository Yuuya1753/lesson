require 'sinatra'

  post '/homework25/submit' do
		content_type :json
    initialize_data()
		data = wordCounter(params[:text]).to_h
    data.to_json
  end
	
	post '/homework25/add' do
		content_type :json
		initialize_data(dataConversion(params[:all_data]))
    data = wordCounter(params[:text]).to_h
    data.to_json
  end

	def initialize_data(all_data = {})
		@word_count = all_data
  end

  def wordCounter(text)
		text.each_line { |line|
			if line.chomp == "" then
				next
      end
			line.gsub!(".", "")
      
			words = lineSplit(line.downcase)

			words.each { |word|
				wordCount(word)
			}
    }
    
    sort_count = []
		sort_count = @word_count.sort { |(k1, v1), (k2, v2)|
			if v1 == v2 then
				k1 <=> k2
			else
				v2 <=> v1
			end
		}

		return sort_count
	end

	private
	def lineSplit(line)
		return line.split
	end

	def wordCount(word)
		if @word_count.has_key?(word) then
			@word_count[word] += 1
		else
			@word_count[word] = 1
		end
	end

	def dataConversion(data)
		conversion_data = data
		data.keys.each { |key|
			conversion_data[key] = data[key].to_i
		}
		return conversion_data
	end