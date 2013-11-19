require "json"
require_relative "../lib/schemata"

module Schemata
  describe Schema do
    let(:simple_json) do
      {
        "id" => 1,
        "name" => "marcos"
      }.to_json
    end

    let(:simple_schema) do
      {
        "type" => "object",
        "properties" => {
          "id" => { "type" => "integer" },
          "name" => { "type" => "string" }
        }
      }.to_json
    end

    it "should be able to transform a simple json into a schema" do
      expect(Schema.generate simple_json).to eq(simple_schema)
    end
  end
end
