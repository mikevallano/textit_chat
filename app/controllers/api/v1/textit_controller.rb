module Api
  module V1
    # https://textit.in/api/v1/webhook/#flow
    class TextitController < ApplicationController
      skip_before_filter :authenticate_user!
      respond_to :json

      def new_chat
        chat = Client.update_or_create_chat(texit_params)
        respond_with chat
      end

      def new_message
        respond_with Message.create(texit_params)
      end

      def new_order
        order = Order.create texit_params
        order.assign_to_all_users
        respond_with order
      end

      private
      def texit_params
        {
          phone_number: params[:phone]
        }
      end
    end
  end
end