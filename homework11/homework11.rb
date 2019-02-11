require 'json'
require '../homework10/homework10.rb'

# JSONファイルをオープン
files = {}
json_file = File.open("homework11.json")
files = JSON.load(json_file)
json_file.close

first = {}
# JSONファイルに書かれたファイルを1つずつオープン
files["Files"].each { |path|
  word_counter = WordCounter.new(path)
  word_counter.count()
  # 未登場の単語、もしくは既存の単語の登場回数よりも多い単語の場合
  if !first.has_key?(word_counter.getFirst()[0]) ||
    first[word_counter.getFirst()[0]] < word_counter.getFirst()[1] then
    # 登場回数を上書きする
    first[word_counter.getFirst()[0]] = word_counter.getFirst()[1]
  end
}

# 登場回数の合計を算出
answerCount = 0
first.each_value { |value|
  answerCount += value
}

p answerCount
