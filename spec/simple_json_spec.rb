require "json"
require_relative "../lib/schemata"

module Schemata
  describe Schema do
    let(:simple_json) do
      {
        "id" => 1,
        "name" => "marcos",
        "price" => 2.0,
        "items" => [1,2]
      }.to_json
    end

    let(:simple_schema) do
      {
        "type" => "object",
        "properties" => {
          "id" => {
            "type" => "integer",
            "required" => true
          },
          "name" => {
            "type" => "string",
            "required" => true
          },
          "price" => {
            "type" => "number",
            "required" => true
          },
          "items" => {
            "type" => "array",
            "required" => true,
            "minItems" => 1,
            "uniqueItems" => true,
            "items" => {
              "type" => "integer",
              "required" => true
            }
          }
        }
      }.to_json
    end

    it "should be able to transform a simple json into a schema" do
      expect(Schema.generate simple_json).to eq(simple_schema)
    end
  end
end
