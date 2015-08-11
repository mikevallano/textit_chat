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
    options.merge!({ locale: I18n.locale }) unless is_default_locale_active?
    options
  end


  def after_sign_in_path_for(resource)
    chats_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  helper_method :is_default_locale_active?
  def is_default_locale_active?
    I18n.locale == I18n.default_locale
  end
end
