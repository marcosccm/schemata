module Schemata
  class Schema
    def self.generate raw_json
      new(raw_json).generate
    end

    def initialize(raw_json)
    end

    def generate
      { 
        "type" => "object",
        "properties" => {
          "id" => { 
            "type" => "integer"
          }
        }
      }.to_json
    end
  end
end
