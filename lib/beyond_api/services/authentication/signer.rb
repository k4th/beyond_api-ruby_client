module BeyondApi
  module Authentication
    class Signer < BaseService
      def all(params = {})
        get("signers", params)
      end

      def create
        post("signers")
      end

      def delete(id)
        Connection.delete("signers/#{id}")
      end
    end
  end
end
