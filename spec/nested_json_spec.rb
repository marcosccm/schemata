require "json"
require_relative "../lib/schemata"

module Schemata
  describe Schema do
    let(:nested_json) do
      {
        "nested" => {
          "name" => "marcos",
          "items" => [1,2]
        }
      }.to_json
    end

    let(:nested_schema) do
      {
        "type" => "object",
        "required" => true,
        "properties" => {
          "nested" => {
            "type" => "object",
            "required" => true,
            "properties" => {
              "name" => {
                "type" => "string",
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
          }
        },
        "$schema" => "http://json-schema.org/draft-03/schema"
      }.to_json
    end

    it "should be able to transform a json with nested objects into a schema" do
      expect(Schema.generate nested_json).to eq(nested_schema)
    end
  end
end
