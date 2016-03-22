require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

cards = YAML.load_file 'spec/test_cypher.yml'

cards.each do |key, card|
  describe 'Test to string from string' do
    before do
      @cc = CreditCard.new(card['number'],
                           card['date'],
                           card['name'],
                           card['type'])
      @key = key.to_i
    end

    describe 'Test ' do
      it 'to_s should serialize the credit card' do
        s = @cc.to_s
        s.must_be_instance_of String
      end

      it 'from_s should deserialize the credit card' do
        s = @cc.to_s
        credit_card = CreditCard.from_s(s)
        credit_card.must_be_instance_of CreditCard
        credit_card.to_s.must_equal @cc.to_s
      end
    end
  end
end
