module Services
  module V1
    ClaimResult = Struct.new(:claim_id, :message, keyword_init: true) do
      def success?
        claim_id.present?
      end
    end
  end
end
