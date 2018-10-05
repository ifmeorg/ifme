# frozen_string_literal: true

module UserRelation
  mattr_accessor :myself, :ally, :incoming_request, :outgoing_request, :other
  MYSELF = 0
  ALLY = 1
  INCOMING_REQUEST = 2
  OUTGOING_REQUEST = 3
  OTHER = 4
end

# rubocop:disable ClassLength
class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper
  include CommentsHelper
  include MomentsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
                       if: proc { |c| c.request.format == 'application/json' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :if_not_signed_in, unless: :devise_controller?
  before_action :set_raven_context, if: proc { Rails.env.production? }

  # i18n
  before_action :set_locale

  # Timezone
  around_action :with_timezone

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end

  # before_action
  # rubocop:disable MethodLength
  def set_locale
    @locales = [
      { name: t('languages.en'), locale: :en },
      { name: t('languages.es'), locale: :es },
      { name: t('languages.nl'), locale: :nl },
      { name: t('languages.pt-BR'), locale: :'pt-BR' },
      { name: t('languages.sv'), locale: :sv },
      { name: t('languages.it'), locale: :it },
      { name: t('languages.nb'), locale: :nb },
      { name: t('languages.vi'), locale: :vi }
    ].freeze
    @locale = I18n.locale = locale
  end
  # rubocop:enable MethodLength

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

  helper_method :avatar_url, :viewer_of?,
                :are_allies?, :get_uid, :most_focus,
                :tag_usage, :can_notify, :if_not_signed_in,
                :generate_comment, :moments_stats

  def if_not_signed_in
    return if user_signed_in?

    respond_to do |format|
      format.html { redirect_to new_user_session_path }
      format.json { head :no_content }
    end
  end

  def are_allies?(user_id1, user_id2)
    users = User.where(id: [user_id1, user_id2])
    users.first.mutual_allies?(users.last)
  end

  def viewer_of?(viewers)
    viewers.include? current_user.id
  end

  def get_uid(user_id)
    User.find(user_id).uid
  end

  # rubocop:disable MethodLength
  
  # rubocop:enable MethodLength

  # rubocop:disable MethodLength
  def tag_usage(data_id, data_type, user_id)
    result = []
    moments = user_moments(user_id).order('created_at DESC')
    if data_type == 'category'
      strategies = user_strategies(user_id).order('created_at DESC')
      [moments, strategies].each do |records|
        objs = []
        records.find_each do |r|
          objs.push(r) if data_included?(data_type, data_id, r)
        end
        result << objs
      end
    elsif data_type.in?(%w[mood strategy])
      moments.find_each do |m|
        result << m if data_included?(data_type, data_id, m)
      end
    end
    result
  end
  # rubocop:enable MethodLength

  private

  def data_included?(data_type, data_id, data)
    return false unless data_type.in?(%w[category mood strategy])

    data_id.in?(data[data_type])
  end

  def record_model_name(record)
    record.class.name.downcase
  end

  def redirect_to_path(path)
    respond_to do |format|
      format.html { redirect_to path }
      format.json { head :no_content }
    end
  end

  def respond_not_saved
    respond_with_json(no_save: true)
  end

  def respond_with_json(reponse)
    respond_to do |format|
      format.html { render json: reponse }
      format.json { render json: reponse }
    end
  end

  def hide_page?(subject)
    (!current_user.mutual_allies?(subject.user) \
    && !subject.viewer?(current_user)) \
    || !subject.published?
  end

  def user_strategies(user_id)
    Strategy.where(user_id: user_id)
  end

  def user_moments(user_id)
    Moment.where(user_id: user_id)
  end

  def set_raven_context
    if user_signed_in?
      Raven.user_context(id: current_user.id)
    end
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
# rubocop:enable ClassLength
