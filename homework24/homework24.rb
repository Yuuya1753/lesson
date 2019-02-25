require 'securerandom'

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
	10.times do
		@data_array.push(SecureRandom.random_number(100))
	end
	@data_array.sort!
end

createData()
puts "配列の内容：#{@data_array}"
puts "任意の数値を入力"
num = gets
puts searchIndex(num.chomp!.to_i)