module DoubleTranspositionCipher
  def self.row_swap(origin, dest, random_key)
    origin.each_with_index{|row, i|
      dest[random_key[i]] = origin[i]
    }
    return dest
  end

  def self.undo_swap(origin, dest, random_key)
    origin.each_with_index{|row, i|
      dest[random_key.index[i]] = origin[i]
    }
    return dest
  end

  def self.encrypt(document, key)
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext

    document = document.to_s
    col = (Math.sqrt(document.length)).ceil
    row = (document.length.to_f / col).ceil
    random_key = Array(0...col).shuffle(random: Random.new(key))
    document = document + ' '*((row * col) - document.length)
    origin_matrix = document.chars.each_slice(col).to_a

    row_sorted_matrix = Array.new(col) { Array.new(col, 0) }
    col_sorted_matrix = Array.new(col) { Array.new(col, 0) }

    row_sorted_matrix = row_swap(origin_matrix, row_sorted_matrix, random_key)
    row_sorted_matrix = row_sorted_matrix.transpose

    col_sorted_matrix = row_swap(row_sorted_matrix, col_sorted_matrix, random_key)
    col_sorted_matrix = col_sorted_matrix.transpose
    col_sorted_matrix.map {|row| row.join}.join
  end

  def self.decrypt(ciphertext, key)
    ciphertext = ciphertext.to_s
    col = (Math.sqrt(ciphertext.length)).ceil
    row = (ciphertext.length.to_f / col).ceil
    random_key = Array(0...col).shuffle(random: Random.new(key))
    ciphertext = ciphertext + ' '*((row * col) - ciphertext.length)
    cipher_matrix = ciphertext.chars.each_slice(col).to_a

    col_sorted_matrix = Array.new(col) { Array.new(col, 0) }
    row_sorted_matrix = Array.new(col) { Array.new(col, 0) }

    col_sorted_matrix = undo_swap(cipher_matrix.transpose,col_sorted_matrix,random_key)
    col_sorted_matrix = col_sorted_matrix.transpose

    row_sorted_matrix = undo_swap(col_sorted_matrix, row_sorted_matrix, random_key)
    row_unsorted_matrix.map {|row| row.join}.join.rstrip
  end
end
