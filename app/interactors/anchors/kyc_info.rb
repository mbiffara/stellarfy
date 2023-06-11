module Stellar
  module Anchors
    class KycInfo
      include Interactor

      delegate :anchor, :jwt, :wallet, to: :context

      before do
        context.jwt = Stellar::Anchors::Auth.call(anchor: anchor, wallet: wallet).jwt
      end

      def call
        context.kyc_info = Stellar::Anchors::Sep12::GetInfo.call(anchor: anchor, jwt: jwt).info
        # context.kyc_info = JSON.parse(response.body)
      end
      # result = Stellar::Anchors::Sep12::GetKycInfo.call(anchor: StellarAnchor.find_by(name: 'AnclapTest'), wallet: Wallet.last, user: User.find_by(email: '
    end
  end
end
