module Services
  module V1
    Result = Struct.new(:code, :message, keyword_init: true) do
      def response
        { response_code: code, message: message }
      end
    end
  end
end
