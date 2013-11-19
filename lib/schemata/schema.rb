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
      Property.for(json).to_json
    end
  end

  class Property < Struct.new(:value)
    def self.for(value)
      table.fetch(value.class).new(value).contents
    end

    def self.table
      {
        Fixnum => IntegerProperty,
        String => StringProperty,
        Float => NumberProperty,
        Array => ArrayProperty,
        Hash => ObjectProperty
      }
    end
  end

  class ObjectProperty < Property
    def contents
      {
        "type" => "object",
        "required" => true,
        "properties" => properties
      }
    end

    def properties
      value.collect do |key, value|
        { key => Property.for(value) }
      end.reduce(:merge)
    end
  end

  class ArrayProperty < Property
    def contents
      {
        "type" => "array",
        "required" => true,
        "minItems" => 1,
        "uniqueItems" => true,
        "items" => Property.for(value.first)
      }
    end
  end

  class StringProperty < Property
    def contents
      { "type" => "string", "required" => true }
    end
  end

  class IntegerProperty < Property
    def contents
      { "type" => "integer", "required" => true }
    end
  end

  class NumberProperty < Property
    def contents
      { "type" => "number", "required" => true }
    end
  end
end
