module Stellar
  module Anchors
    module Sep12
      class PutUserKycInfo
        include Interactor

        delegate :anchor, :requirements, :user, :user_kyc_info, to: :context

        before do
          context.user_kyc_info = Stellar::Anchors::Sep12::BuildUserKycInfo.call(user: user, requirements: requirements).user_kyc_info
        end

        def call
          byebug
          context.response = Faraday.put(
            "#{anchor.toml.kyc_server}/#{user.id}",
            user_kyc_info.to_json,
            "Content-Type" => "application/json"
          )
        end

        private

        def build_user_kyc_info
          user_kyc_info = {}

          anchor.toml.kyc_server_requirements.each do |requirement|
            user_kyc_info[requirement] = user.send(requirement)
          end

          user_kyc_info
        end
      end
    end
  end
end
