class PushNotificationsController < ApplicationController
  before_action :set_push_notification, only: [:show, :edit, :update, :destroy]

  respond_to :html

  layout "navbar_only"

  def index
    @push_notifications = PushNotification.all
    respond_with(@push_notifications)
  end

  def show
    respond_with(@push_notification)
  end

  def new
    @push_notification = PushNotification.new
    respond_with(@push_notification)
  end

  def edit
  end

  def create
    @push_notification = PushNotification.new(push_notification_params)
    @push_notification.save
    respond_with(@push_notification)
  end

  def update
    @push_notification.update(push_notification_params)
    respond_with(@push_notification)
  end

  def destroy
    @push_notification.destroy
    respond_with(@push_notification)
  end

  private
    def set_push_notification
      @push_notification = PushNotification.find(params[:id])
    end

    def push_notification_params
      params.require(:push_notification).permit(:tag, :message)
    end
end
