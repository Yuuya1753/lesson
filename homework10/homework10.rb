class WordCounter
  def initialize(path)
    # ファイルをオープン
    @file = File.open(path)
  end

  # ファイル内の全単語毎のカウント
  def count()
    # 単語毎の出現数を格納するハッシュ
    @word_count = {}

    # ファイルの内容を一行ずつ取り出す
    @file.each_line { |line|
      # 空行（改行コードしかない行）の場合、次の行へ
      if line.chomp == "" then
        next
      end
      lineSplit(line.downcase)
    }

    # ファイルをクローズ
    @file.close

    # 登場回数の多い順にソート
    @desc_word_count = []
    @desc_word_count = @word_count.sort { |a, b| b[1] <=> a[1] }
  end

  # 出力
  def getFirst()
    # 一番最初を返す
    return @desc_word_count[0]
  end

  private
  # 1行を単語毎に分割
  def lineSplit(line)
    # 空白で分割（単語毎に分割）
    words = line.split

    # 一番最後の"."（ピリオド）を削除
    words[words.length - 1] = words[words.length - 1].chop
    # 単語をアルファベット順にソート
    words.sort! { |a, b| a.downcase <=> b.downcase }

    # 単語を一つずつ取り出す
    words.each { |word|
      wordCount(word)
    }
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

if __FILE__ == $0 then
  path = "homework10.txt"
  word_counter = WordCounter.new(path)
  word_counter.count()
  p word_counter.getFirst()[0]
end
