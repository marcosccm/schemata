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
      json.collect { |key, value| Property.new(key, value).contents }.reduce(:merge)
    end

    class Type
      def self.for(key)
        table.fetch(key)
      end

      def self.table
        {
          Fixnum => "integer",
          String => "string",
          Float => "number",
          Array => "array"
        }
      end
    end

    class Property < Struct.new(:key, :value)
      def contents
        {
          key => {
            "type" => Type.for(value.class),
            "required" => true
          }
        }
      end
    end
  end
end
