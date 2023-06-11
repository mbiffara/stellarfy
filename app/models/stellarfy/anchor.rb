require "open-uri"

module Stellarfy
  class Anchor < ApplicationRecord

    def toml
      return Stellarfy::Toml.new(parsed_toml) if parsed_toml.any? && toml_parsed_at > 1.day.ago
  
      update_toml
    rescue StandardError => e
      Rails.logger.error("Error updating parsed TOML file: #{e.message}")
      nil
    end
  
    def update_toml
      return unless fetch_toml
  
      update(
        toml_parsed_at: Time.now,
        parsed_toml: parse_toml(fetch_toml)
      )
  
      Stellarfy::Toml.new(parsed_toml)
    end
  
    private
  
    def parse_toml(toml_content)
      TomlRB.parse(toml_content)
    rescue StandardError => e
      Rails.logger.error("Error parsing TOML file: #{e.message}")
      nil
    end
  
    def fetch_toml
      return unless toml_url
  
      @fetch_toml ||= Faraday.get(toml_url).body
    rescue OpenURI::HTTPError => e
      Rails.logger.error("Error fetching TOML file for #{toml_url}: #{e.message}")
      nil
    end
  end
end
