require "json"
require_relative "../lib/schemata"

module Schemata
  describe Schema do
    let(:simple_json) { { "id" => 1 }.to_json }
    let(:simple_schema) do
      { "type" => "object", "properties" => { "id" => { "type" => "integer" } } }.to_json
    end

    it "should be able to transform a simple json into a schema" do
      expect(Schema.generate simple_json).to eq(simple_schema)
    end
  end
end
