class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # include Pundit
  before_action :authenticate_user!
  # after_action :verify_authorized

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end


  def after_sign_in_path_for(resource)
    chats_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
