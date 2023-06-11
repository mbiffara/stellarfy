module Stellar
  module Anchors
    module Sep10
      class BuildEnvelopeAndSign
        include Interactor

        delegate :anchor, :challenge_transaction, :envelope, :envelope_xdr, :wallet, to: :context

        before do
          context.envelope = Stellar::TransactionEnvelope.from_xdr(challenge_transaction["transaction"], "base64")
        end

        def call
          sign_envelope

          context.envelope_xdr = context.envelope.to_xdr(:base64)
        end

        def sign_envelope
          context.envelope.signatures += [
            context.envelope.tx.sign_decorated(context.wallet.account.keypair)
          ]
        end
      end
    end
  end
end
