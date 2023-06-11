module Stellar
  module Anchors
    module Sep10
      class SendSignedTransaction
        include Interactor

        delegate :anchor, :envelope_xdr, :wallet, to: :context

        def call
          response = faraday_connection.post do |req|
            req.body = { transaction: envelope_xdr }.to_json
          end

          context.jwt = JSON.parse(response.body)["token"]
        end

        def faraday_connection
          @faraday_connection ||= Faraday.new(
            url: anchor.toml.web_auth_endpoint,
            headers: { "Content-Type" => "application/json" }
          )
        end
      end
    end
  end
end
