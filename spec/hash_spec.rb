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
          card.hash.wont_equal card.to_s
          card.hash.wont_be_nil
          card.hash.must_equal card.hash
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
          card.hash.wont_equal card.to_s
          card.hash.wont_be_nil
          card.hash.must_equal card.hash
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
          card.hash.wont_equal card.hash_secure
        end
      end
    end
  end
end
