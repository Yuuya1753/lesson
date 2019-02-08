# ファイルをオープン
file = File.open("homework9.txt")

# 単語毎の出現数を格納するハッシュ
word_count = {}

# ファイルの内容を一行ずつ取り出す
file.each_line { |line|
  # 空白で分割（単語毎に分割）
  words = line.split
  # 一番最後の"."（ピリオド）を削除
  words[words.length - 1] = words[words.length - 1].chop
  # 単語をアルファベット順にソート
  words.sort! { |a, b| a.downcase <=> b.downcase }

  # 単語を一つずつ取り出す
  words.each { |word|
    # 既に登場した単語の場合、値に1加算
    if word_count.has_key?(word) then
      word_count[word] += 1
    # 初登場の単語の場合、値に1を設定
    else
      word_count[word] = 1
    end
  }
}

# ファイルをクローズ
file.close

# 登場回数の多い順にソート
desc_word_count = {}
desc_word_count = word_count.sort { |a, b| b[1] <=> a[1] }.to_h

# 一番最初のキーを出力
p desc_word_count.keys[0]
