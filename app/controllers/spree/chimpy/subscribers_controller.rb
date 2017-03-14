class Spree::Chimpy::SubscribersController < ApplicationController
  respond_to :json

  def create
    @subscriber = Spree::Chimpy::Subscriber.where(email: subscriber_params[:email]).first_or_initialize
    @subscriber.email = subscriber_params[:email]
    @subscriber.subscribed = subscriber_params[:subscribed]
    if @subscriber.save
      if @subscriber.subscribed
        render json: { status: 200, msg: Spree.t(:success, scope: [:chimpy, :subscriber]) }
      else
        render json: { status: 200, msg: Spree.t(:unsubscribe_success, scope: [:chimpy, :subscriber]) }
      end
    else
      render json: { status: 500, msg: Spree.t(:failure, scope: [:chimpy, :subscriber]) }
    end
  end

  private

    def subscriber_params
      params.require(:chimpy_subscriber).permit(:email, :subscribed)
    end
end
