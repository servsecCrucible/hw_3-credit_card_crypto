multi_d_array = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]

require 'pp'
# matrix = Array.new(4) { Array.new(4, 0) }
hey = 'helloworlddjs'
doc = hey.to_s
col = (Math.sqrt(hey.length)).ceil
row = (hey.length.to_f / col).ceil

random_key = Array(0...col).shuffle(random: Random.new(3))
document = hey + ' '*((row * col)-hey.length)
matrix = document.chars.each_slice(col).to_a

# # pp matrix
pp random_key
origin = Array.new(col) { Array.new(col, 0) }
new_matrix = Array.new(col) { Array.new(col, 0) }
matrix.each_with_index{|row, i|
  origin[i] = matrix[i].flatten
}

matrix.each_with_index{|row, i|
  new_matrix[random_key[i]] = origin[i]
}

pp new_matrix
pp origin
