require 'sinatra'
  post '/homework23' do
    content_type :json
    initialize()
    data = wordCounter(params[:text]).to_h
    data.to_json
  end

  def initialize()
    @word_count = {}
  end

  def wordCounter(text)
		text.each_line { |line|
			if line.chomp == "" then
				next
      end
      
			words = lineSplit(line.downcase)

			words[-1].chop!
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