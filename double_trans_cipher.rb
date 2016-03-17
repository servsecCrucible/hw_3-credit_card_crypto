## DoubleTranspositionCipher
module DoubleTranspositionCipher
  def self.row_swap(origin, dest, random_key)
    origin.each_with_index do |_row, i|
      dest[random_key[i]] = origin[i]
    end
    dest
  end

  def self.undo_swap(origin, dest, random_key)
    origin.each_with_index do |_row, i|
      dest[random_key.index(i)] = origin[i]
    end
    dest
  end

  def self.init_matrix(string, key)
    string = string.to_s
    size = Math.sqrt(string.length).ceil
    random_key = Array(0...size).shuffle(random: Random.new(key))
    string += ' ' * ((size**2) - string.length)
    matrix = string.chars.each_slice(size).to_a
    [matrix, random_key, size]
  end

  def self.encrypt(document, key)
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext

    origin_matrix, random_key, col = init_matrix(document, key)

    row_sorted_matrix = Array.new(col) { Array.new(col, 0) }
    col_sorted_matrix = Array.new(col) { Array.new(col, 0) }

    row_sorted_matrix = row_swap(origin_matrix, row_sorted_matrix, random_key)
    row_sorted_matrix = row_sorted_matrix.transpose

    col_sorted_matrix = row_swap(row_sorted_matrix, col_sorted_matrix, random_key)
    col_sorted_matrix = col_sorted_matrix.transpose
    col_sorted_matrix.map(&:join).join
  end

  def self.decrypt(ciphertext, key)
    cipher_matrix, random_key, col = init_matrix(ciphertext, key)

    col_sorted_matrix = Array.new(col) { Array.new(col, 0) }
    row_sorted_matrix = Array.new(col) { Array.new(col, 0) }

    col_sorted_matrix = undo_swap(cipher_matrix.transpose, col_sorted_matrix, random_key)
    col_sorted_matrix = col_sorted_matrix.transpose

    row_sorted_matrix = undo_swap(col_sorted_matrix, row_sorted_matrix, random_key)
    row_sorted_matrix.map(&:join).join.rstrip
  end
end
