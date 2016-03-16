module DoubleTranspositionCipher
  module_function

  def encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    doc = document.to_s
    len = (doc.size**0.5).to_i
    len += 1
    tab = table(len, key)
    res = Array.new(len**2, ' ')
    doc.chars.each.with_index do |c, i|
      res[(len * tab[i / len]) + tab[i % len]] = c
    end
    res.join
  end

  def decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    doc = ciphertext.to_s
    len = (doc.size**0.5).to_i
    tab = table(len, key)
    res = Array.new(len**2, ' ')
    doc.chars.each.with_index do |c, i|
      res[(len * tab.index(i / len)) + tab.index(i % len)] = c
    end
    res.join.strip!
  end

  def table(length, key)
    (0..(length - 1)).to_a.shuffle(random: Random.new(key))
  end
end
