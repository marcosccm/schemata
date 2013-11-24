require "json"
require_relative "../../lib/schemata"

module Schemata 
  describe Schema do
    it "treats nil json content as an empty json object" do
      expect(Schema.new(nil).json).to eq(Hash.new)
    end
  end
end
