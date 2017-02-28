class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
  include SessionsHelper

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
