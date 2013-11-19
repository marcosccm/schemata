module Schemata
  class Schema
    attr_reader :json

    def self.generate raw_json
      new(raw_json).generate
    end

    def initialize(raw_json)
      @json = JSON.load(raw_json)
    end

    def generate
      { "type" => "object" }.merge("properties" =>  entity_properties).to_json
    end

    def entity_properties
      json.collect { |key, value| entity_content(key, value) }.reduce(:merge)
    end

    def entity_content(key, value)
      {
        key => {
          "type" => type_table[value.class],
          "required" => true
        }
      }
    end

    def type_table
      { 
        Fixnum => "integer",
        String => "string"
      }
    end
  end
end
