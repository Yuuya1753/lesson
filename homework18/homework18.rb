require 'json'

class WordCounter
	def initialize(path)
		# ファイルをオープン
		@file = File.open(path)
		# 単語毎の出現数を格納するハッシュ
		@word_count = {}
	end

	# ファイル内の全単語毎のカウント
	def count()
		# ファイルの内容を一行ずつ取り出す
		@file.each_line { |line|
			# 空行（改行コードしかない行）の場合、次の行へ
			if line.chomp == "" then
				next
			end

			words = lineSplit(line.downcase)
			
			# 一番最後の"."（ピリオド）を削除
			words[-1].chop!
			# 単語を一つずつ取り出す
			words.each { |word|
				if word !~ /\[\d{4}\]/ then
					wordCount(word)
				end
			}
		}

		# ファイルをクローズ
		@file.close

		sort_count = []
		sort_count = @word_count.sort { |(k1, v1), (k2, v2)|
			if v1 == v2 then
				k1 <=> k2
			else
				v2 <=> v1
			end
		}

		return sort_count[0, 10].to_h
	end

	private
	# 1行を単語毎に分割
	def lineSplit(line)
		# 空白で分割（単語毎に分割）した配列を返却
		return line.split
	end

	# 単語毎のカウント
	def wordCount(word)
		# 既に登場した単語の場合、値に1加算
		if @word_count.has_key?(word) then
			@word_count[word] += 1
		# 初登場の単語の場合、値に1を設定
		else
			@word_count[word] = 1
		end
	end
end

# JSONファイルをオープン
directories = {}
json_file = File.open("homework18.json")
directories = JSON.load(json_file)
json_file.close

files = []
# JSONファイルに書かれたディレクトリのファイルを1つずつオープン
directories["Directories"].each { |dir|
	Dir.children(dir).each { |file|
		file_count = {}
		path = dir + file
		word_counter = WordCounter.new(path)
		file_count[path] = word_counter.count()
		files.push file_count
	}
}

all_files = {"Files": files}

# JSONファイルに出力
open("output.json", "w") { |file|
	JSON.dump(all_files, file)
}
