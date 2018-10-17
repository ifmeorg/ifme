# frozen_string_literal: true
# rubocop:disable ClassLength
class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include CommentsHelper
  include CommentFormHelper
  include TagsHelper
  include MomentsHelper

  protect_from_forgery with: :null_session,
                       if: proc { |c| c.request.format == 'application/json' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :if_not_signed_in, unless: :devise_controller?
  before_action :set_raven_context, if: proc { Rails.env.production? }
  before_action :set_locale
  around_action :with_timezone
  helper_method :most_focus, :if_not_signed_in, :redirect_to_path

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end

  # before_action
  def set_locale
    @locale = I18n.locale = locale
    @locales = Rails.application.config.i18n.available_locales
  end

  def locale
    current_user&.locale || cookies[:locale] || I18n.default_locale
  end

  def configure_permitted_parameters
    common = %i[location name email password
                password_confirmation current_password]
    configure_for_account_update(common)
    configure_for_sign_up(common)
    configure_for_accept_invitation
  end

  def configure_for_account_update(common)
    devise_parameter_sanitizer.permit :account_update,
                                      keys: %i[about avatar
                                               remove_avatar comment_notify
                                               ally_notify group_notify
                                               meeting_notify] + common
  end

  def configure_for_sign_up(common)
    devise_parameter_sanitizer.permit :sign_up, keys: common
  end

  def configure_for_accept_invitation
    devise_parameter_sanitizer.permit :accept_invitation,
                                      keys: %i[name password
                                               password_confirmation
                                               invitation_token]
  end

  def redirect_to_path(path)
    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end

  def if_not_signed_in
    return if user_signed_in?

    redirect_to_path(new_user_session_path)
  end

  # rubocop:disable MethodLength
  # TODO: move this method out of the controller + refactor
  def most_focus(data_type, profile_id)
    data = []
    user_id = profile_id || current_user.id
    user = User.find_by(id: user_id)
    moments =
      if current_user.id == profile_id
        user.moments
      else
        user.moments.where.not(published_at: nil)
      end
    if data_type == 'category'
      [moments, user.strategies].each do |records|
        records.where(user_id: user_id).find_each do |r|
          if r.category.any? && (profile_id.blank? ||
                                 profile_exists?(profile_id, r))
            data += r.category
          end
        end
      end
    elsif data_type.in?(%w[mood strategy])
      moments.find_each do |m|
        data_obj = m[data_type]
        if data_obj.any? && (profile_id.blank? ||
                             profile_exists?(profile_id, m))
          data += data_obj
        end
      end
    end

    data.empty? ? {} : top_three_focus(data)
  end
  # rubocop:enable MethodLength

  private

  def profile_exists?(profile, data)
    profile.present? &&
      (current_user.id == profile ||
       data.viewers.include?(current_user.id))
  end

  # TODO: refactor calling method to pass a hash to start with
  def top_three_focus(data)
    # Turn data array into hash of value => freq_of_value
    freq = data.each_with_object(Hash.new(0)) do |value, hash|
      hash[value] += 1
    end

    # Sort hash and take highest 3 values
    freq.sort_by do |occurrences, _value|
      occurrences
    end[0..2].to_h
  end

  def set_raven_context
    Raven.user_context(id: current_user.id) if user_signed_in?
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
# rubocop:enable ClassLength
