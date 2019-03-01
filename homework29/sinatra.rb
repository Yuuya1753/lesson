require 'sinatra'
require 'mysql2'

configure do
	client = Mysql2::Client.new(:host => 'localhost', :encoding => 'utf8', :username => 'root', :password => 'Root_1753', :socket => '/var/lib/mysql/mysql.sock', :database => 'homework29_database')
	result = client.query("SHOW TABLES LIKE 'homework29_table' ;")
	result.each { |row|
		client.query("drop table homework29_table;")
	}
	client.query("create table homework29_table (address varchar(255), textData text, date datetime);")
end

post '/homework29/submit' do
	content_type :json
	initialize_data()
	data = wordCounter(params[:text]).to_h
	data.to_json
end

post '/homework29/add' do
	content_type :json
	initialize_data(dataConversion(params[:all_data]))
	data = wordCounter(params[:text]).to_h
	data.to_json
end

post '/homework29/reg' do
	client = Mysql2::Client.new(:host => 'localhost', :encoding => 'utf8', :username => 'root', :password => 'Root_1753', :socket => '/var/lib/mysql/mysql.sock', :database => 'homework29_database')
	client.query("insert into homework29_table (address, textData, date) values('#{request.ip}', '#{params[:text]}', '#{Time.now.strftime("%F %T")}');")
end

get '/homework29/get' do
	content_type :json
	text = ""
	initialize_data()
	client = Mysql2::Client.new(:host => 'localhost', :encoding => 'utf8', :username => 'root', :password => 'Root_1753', :socket => '/var/lib/mysql/mysql.sock', :database => 'homework29_database')
	result = client.query("select * from homework29_table where address = '#{request.ip}';")
	# p result
	result.each { |row|
		# p row["textData"]
		text = text + row["textData"] + "\n"
	}
	data = wordCounter(text).to_h
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
		return line.split(/[ |\[|\]]/)
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