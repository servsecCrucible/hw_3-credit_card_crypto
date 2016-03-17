require 'pp'
hey = '4716745052999353'
doc = hey.to_s
col = (Math.sqrt(hey.length)).ceil
row = (hey.length.to_f / col).ceil

random_key = Array(0...col).shuffle(random: Random.new(3))
document = hey + ' '*((row * col)-hey.length)
matrix = document.chars.each_slice(col).to_a

row_sorted_matrix = Array.new(col) { Array.new(col, 0) }
col_sorted_matrix = Array.new(col) { Array.new(col, 0) }

def row_swap(origin, dest, random_key)
  origin.each_with_index{|row, i|
    dest[random_key[i]] = origin[i]
  }
  return dest
end


row_sorted_matrix = row_swap(matrix, row_sorted_matrix, random_key)
row_sorted_matrix = row_sorted_matrix.transpose
col_sorted_matrix = row_swap(row_sorted_matrix, col_sorted_matrix, random_key).transpose

pp col_sorted_matrix
pp col_sorted_matrix.map {|row| row.join}.join

def undo_swap(origin, dest, random_key)
  origin.each_with_index{|row, i|
    dest[random_key.index(i)] = origin[i]
  }
  return dest
end

col_unsorted_matrix = Array.new(col) { Array.new(col, 0) }
row_unsorted_matrix = Array.new(col) { Array.new(col, 0) }

col_unsorted_matrix = undo_swap(col_sorted_matrix.transpose,col_unsorted_matrix,random_key).transpose

row_unsorted_matrix = undo_swap(col_unsorted_matrix, row_unsorted_matrix, random_key)
pp row_unsorted_matrix.map {|row| row.join}.join.rstrip

# def self.row_unexchange(matrix, random_key)
#       matrix.each_with_index.map {|row,i| [random_key.index(i),row]}.sort.map {|k,v| v}
#   end
