module Stellar
  module Anchors
    module Sep12
      class GetInfo
        include Interactor

        delegate :anchor, :jwt, to: :context

        def call
          context.fail!(error: "anchor.toml.kyc_server is blank") if anchor.toml.kyc_server.blank?

          context.info = kyc_info
        end

        private

        def kyc_info
          Rails.logger.info "kyc_info"
          Rails.logger.info "kyc_server: #{kyc_server}"
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

        def kyc_server
          @kyc_server ||= anchor.toml.kyc_server
        end
      end
    end
  end
end
