module Stellar
  module Anchors
    # USAGE
    # result = Stellar::Anchors::Auth.call(anchor: StellarAnchor.find_by(name: 'AnclapTest'), wallet: Wallet.last)

    class Auth
      include Interactor::Organizer
      # result = Stellar::Anchors::Auth.call(anchor: StellarAnchor.find_by(name: 'AnclapTest'), wallet: Wallet.last)

      organize Stellar::Anchors::Sep10::GetChallengeTransaction,
        Stellar::Anchors::Sep10::BuildEnvelopeAndSign,
        Stellar::Anchors::Sep10::SendSignedTransaction
    end
  end
end
