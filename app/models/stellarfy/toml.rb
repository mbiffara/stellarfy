require "open-uri"

module Stellarfy
  class Toml
    attr_accessor :parsed_toml

    def initialize(parsed_toml)
      @parsed_toml = parsed_toml.deep_symbolize_keys.transform_keys(&:downcase).compact
    end
  
    def accounts
      parsed_toml.fetch(:accounts, [])
    end
  
    def currencies(code = nil)
      return parsed_toml.fetch(:currencies, []) unless code
  
      currencies.select { |currency| currency[:code] == code }
    end
  
    def respond_to_missing?(method, include_private = false)
      parsed_toml.key?(method) || super
    end
  
    def method_missing(method, *_args, &_block)
      parsed_toml[method]
    end
  end
end
