module Stellar
  module Anchors
    module Sep12
      class BuildUserKycInfo
        include Interactor

        delegate :field_mapper, :requirements, :user, to: :context

        before do
          context.field_mapper = UserKycFieldMapper.new(user)
        end

        def call
          context.user_kyc_info = build_user_kyc_info
        end

        private

        def build_user_kyc_info
          user_kyc_info = {}

          requirements.fields.each do |required_field|
            user_kyc_info[required_field.name] = field_mapper.user_data(required_field)
          end

          user_kyc_info
        end
      end
    end
  end
end
