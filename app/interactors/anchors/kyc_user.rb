module Stellar
  module Anchors
    class KycUser
      include Interactor::Organizer

      delegate :anchor, :wallet, :user, :user_jwt, to: :context

      before do
        context.user_jwt = Stellar::Anchors::Auth.call(anchor: anchor, user: user, wallet: Wallet.last).jwt
        context.kyc_record = StellarAnchorKyc.find_or_create_by(user: user, stellar_anchor: anchor)
      end

      def call
        return if context.kyc_record.status == "verified"

        context.kyc_info = JSON.parse(Stellar::Anchors::Sep12::GetInfo.call(anchor: anchor, jwt: user_jwt).info)

        put_user_kyc_info if requirements.needs_info?
      end

      def put_user_kyc_info
        context.response = Stellar::Anchors::Sep12::PutUserKycInfo.call(
          anchor: anchor,
          user: user,
          jwt: user_jwt,
          requirements: requirements,
          kyc_verification: kyc_verification
        ).response

        context.kyc_info = JSON.parse(context.response.body)
      end

      def requirements
        StellarKycRequirements.new(context.kyc_info)
      end

      def kyc_verification
        Kyc::GetVerificationData.call(user: user).verification_data
      end
    end
  end
end
