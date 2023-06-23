module Stellar
  module Anchors
    module Sep38
      class GetInfo
        include Interactor

        delegate :anchor, :jwt, to: :context

        def call
          context.fail!(error: "anchor.toml.sep_38 is blank") if anchor.toml.sep_38.blank?

          context.info = sep_info
        end

        private

        def sep_info
          Rails.logger.info "sep38_info"
          Rails.logger.info "sep38_server: #{sep38_server}"
          Rails.logger.info "jwt: #{jwt}"

          response = faraday_connection.get
          response.body
        end

        def faraday_connection
          @faraday_connection ||= Faraday.new(
            url: "#{kyc_server}/customer",
            headers: {
              "Content-Type" => "application/json",
              "Authorization" => "Bearer #{jwt}"
            }
          )
        end

        def sep38_server
          @sep38_server ||= anchor.toml.sep_38
        end
      end
    end
  end
end
