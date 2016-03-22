require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

data = YAML.load_file 'spec/test_cypher.yml'
card_details = []

data.each do |_key, card|
  card_details << CreditCard.new(card['number'], card['expiration_date'], \
                                 card['owner'], card['credit_network'])
end

card_details.each_with_index do |card, i|
  describe 'Test hashing requirements' do
    describe 'Test regular hashing' do
      describe 'Check hashes are consistently produced' do
        # TODO: Check that each card produces the same hash if hashed repeatedly
        it 'should check for hash consitency' do
          hash1 = card.hash
          hash2 = card.hash
          hash1.wont_equal card.to_s
          hash1.wont_be_nil
          hash1.must_equal hash2
        end
      end

      describe 'Check for unique hashes' do
        # TODO: Check that each card produces a different hash than other cards
        it 'should check for uniquness amongst cards' do
          hash = card.hash
          remainder = card_details[i + 1..card_details.length]
          remainder.each do |c|
            hash.wont_equal c.hash
          end
        end
      end
    end

    describe 'Test cryptographic hashing' do
      describe 'Check hashes are consistently produced' do
        # TODO: Check that each card produces the same hash if hashed repeatedly
        it 'should check for hash consitency' do
          hash1 = card.hash_secure
          hash2 = card.hash_secure
          hash1.wont_equal card.to_s
          hash1.wont_be_nil
          hash1.must_equal hash2
        end
      end

      describe 'Check for unique hashes' do
        # TODO: Check that each card produces a different hash than other cards
        it 'should check for uniquness amongst cards' do
          hash = card.hash_secure
          remainder = card_details[i + 1..card_details.length]
          remainder.each do |c|
            hash.wont_equal c.hash_secure
          end
        end
      end

      describe 'Check regular hash not same as cryptographic hash' do
        # TODO: Check that each card's hash is different from its hash_secure
        it 'should check for uniquness amongst cards' do
          hash1 = card.hash
          hash2 = card.hash_secure
          hash1.wont_equal hash2
        end
      end
    end
  end
end
