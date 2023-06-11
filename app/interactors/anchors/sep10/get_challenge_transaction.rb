module Stellar
  module Anchors
    module Sep10
      class GetChallengeTransaction
        include Interactor

        delegate :anchor, :wallet, :user, to: :context

        attr_reader :challenge_transaction_url

        before do
          @challenge_transaction_url = "#{anchor.toml.web_auth_endpoint}?account=#{wallet.address}"
          @challenge_transaction_url = "#{anchor.toml.web_auth_endpoint}?account=#{wallet.address}#memo=#{user.id}" if user.present?
        end

        def call
          context.challenge_transaction = JSON.parse(Faraday.get(challenge_transaction_url).body)
        end
      end
    end
  end
end
