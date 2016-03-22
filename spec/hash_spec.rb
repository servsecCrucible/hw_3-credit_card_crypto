require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { number: '4916603231464963', expiration_date: 'Mar-30-2020', \
    owner: 'Soumya Ray', credit_network: 'Visa' },
  { number: '6011580789725897', expiration_date: 'Sep-30-2020', \
    owner: 'Nick Danks', credit_network: 'Visa' },
  { number: '5423661657234057', expiration_date: 'Feb-30-2020', \
    owner: 'Lee Chen', credit_network: 'Mastercard' }
]

cards = card_details.map { |c| CreditCard.new(c[:number], \
  c[:expiration_date], c[:owner], c[:credit_network]) }

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
    end
  end
end
