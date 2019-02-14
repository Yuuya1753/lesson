require 'json'

class WordCounter
	def initialize(path)
		# ファイルをオープン
		@file = File.open(path)
		@word_count = {}
	end

	# ファイル内の全単語毎のカウント
	# 引数：カウント済のハッシュ
	def count(all_count = {})
		# 単語毎の出現数を格納するハッシュ
		@word_count = all_count

		# ファイルの内容を一行ずつ取り出す
		@file.each_line { |line|
			# 空行（改行コードしかない行）の場合、次の行へ
			if line.chomp == "" then
				next
			end
			# 一番最後の"."（ピリオド）を削除
			words = lineSplit(line.downcase)

			words[-1].chop!
			# 単語を一つずつ取り出す
			words.each { |word|
				wordCount(word)
			}
		}

		# ファイルをクローズ
		@file.close

		return @word_count
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
files = {}
json_file = File.open("homework17.json")
files = JSON.load(json_file)
json_file.close

all_words = {}
# JSONファイルに書かれたファイルを1つずつオープン
files["Files"].each { |path|
	word_counter = WordCounter.new(path)
	all_words = word_counter.count(all_words)
}

# 登場回数が1回より多い回数を抽出
count_array = []
count_array = all_words.values.select { |count| count > 1 }
# 平均
average = count_array.sum / count_array.length
# 分散
variance = (count_array.sum { |count| count ** 2 } / count_array.length) - (average ** 2)
variance2 = count_array.sum { |count| (count-average)**2 } / count_array.length
# 標準偏差
standard_deviation = Math.sqrt(variance)

puts "平均:#{average} 分散:#{variance} 標準偏差:#{standard_deviation}"
