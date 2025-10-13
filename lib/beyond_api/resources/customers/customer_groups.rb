# frozen_string_literal: true

require "beyond_api/utils"

module BeyondApi
  module CustomerGroups
    def all(params = {})
      response, status = BeyondApi::Request.get(@session, "/customer-groups", params)

      handle_response(response, status)
    end

    def add_customer(customer_id, customer_group_ids)
      response, status = BeyondApi::Request.post(@session,
                                                 "/customers/#{customer_id}/customer-groups",
                                                 customer_group_ids)

      handle_response(response, status)
    end
  end
end
