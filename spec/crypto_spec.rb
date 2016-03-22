require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../aes_cipher'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_cypher.yml'

cards.each do |key, card|
  describe 'Test card info encryption' do
    before do
      @cc = CreditCard.new(card['number'], card['date'], card['name'], \
                           card['type'])
      @key = key.to_i
    end

    ciphers = [
      ['Caesar cipher', SubstitutionCipher::Caesar],
      ['Permutation cipher', SubstitutionCipher::Permutation],
      ['Double transposition cipher', DoubleTranspositionCipher],
      ['AesCipher', AesCipher]
    ]

    ciphers.each do |_name, method|
      describe 'Using #{name}' do
        it 'should encrypt card information' do
          enc = method.encrypt(@cc, @key)
          enc.wont_equal @cc.to_s
          enc.wont_be_nil
        end

        it 'should decrypt text' do
          enc = method.encrypt(@cc, @key)
          dec = method.decrypt(enc, @key)
          dec.must_equal @cc.to_s
        end
      end
    end
  end
end
