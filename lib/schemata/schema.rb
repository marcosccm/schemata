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
      json.collect { |key, value| Property.for(key, value).contents }.reduce(:merge)
    end
  end

  class Property < Struct.new(:key, :value)
    def self.for(key, value)
      table.fetch(value.class).new(key, value)
    end

    def self.table
      {
        Fixnum => IntegerProperty,
        String => StringProperty,
        Float => NumberProperty,
        Array => ArrayProperty
      }
    end
  end

  class ArrayProperty < Property
    def contents
      {
        key => { "type" => "array", "required" => true }
      }
    end
  end

  class StringProperty < Property
    def contents
      {
        key => { "type" => "string", "required" => true }
      }
    end
  end

  class IntegerProperty < Property
    def contents
      {
        key => { "type" => "integer", "required" => true }
      }
    end
  end

  class NumberProperty < Property
    def contents
      {
        key => { "type" => "number", "required" => true }
      }
    end
  end
end
