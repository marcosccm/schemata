require "json"
require_relative "../../lib/schemata"

module Schemata 
  describe Schema do
    it "treats nil json input as an empty json object" do
      expect(Schema.new(nil).json).to eq(Hash.new)
    end

    it "treats blank json input as an empty json object" do
      expect(Schema.new("").json).to eq(Hash.new)
    end

    context "when generating the schema" do
      it "adds the $schema key" do
        expect(JSON.load(Schema.new("").generate)["$schema"]).to eq "http://json-schema.org/draft-03/schema"
      end
    end
  end
end
