module Stellar
  module Anchors
    # USAGE
    # result = Stellar::Anchors::Auth.call(anchor:, wallet:)

    class Auth
      include Interactor::Organizer

      organize Stellar::Anchors::Sep10::GetChallengeTransaction,
        Stellar::Anchors::Sep10::BuildEnvelopeAndSign,
        Stellar::Anchors::Sep10::SendSignedTransaction
    end
  end
end
