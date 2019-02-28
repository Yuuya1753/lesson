require 'securerandom'
require 'benchmark'


# 引数の数値が配列に含まれる場合はそのインデックスを
# 含まれない場合は-1を返す
def searchIndex(num)
	if @data_array.include?(num) then
		return @data_array.index(num)
	else
		return -1
	end
end

# 動作確認用
def createData()
	@data_array = []
	1000000.times do
		@data_array.push(SecureRandom.random_number(10000000))
	end
	@data_array.sort!
end

# puts "配列の内容：#{@data_array}"
createData()
result_time = Benchmark.realtime {
	1000000.times do
		searchIndex(SecureRandom.random_number(10000000))
	end
}
puts "処理時間：#{result_time.round(3) * 1000}ミリ秒"