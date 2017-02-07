class Api::BaseController < ApplicationController

#  before_action :authenticate_user_from_token!
#  before_action :authenticate_user!
#  before_action :token_expired!
#  before_action :renew_token

  def pagination_dict(object, extra_meta = {})
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }.merge(extra_meta)
  end

  protected

  def authenticate_user_from_token!
    user_email = request.headers['X-User-Email'].presence
    user       = user_email && User.find_for_authentication(email: user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, request.headers['X-User-Token'])
      @current_user = user
    end
  end

  def authenticate_user!
    unless @current_user
      return render :json => {
        :error => {
          :description => t("devise.failure.unauthenticated"),
          :code => 401
        }
      }, :status => 401
    end
  end

  def token_expired!
    if @current_user
      if @current_user.current_authentication.expired?
        return render :json => {
          :error => {
            :description => t("devise.failure.timeout"),
            :code => 410
          }
        }, :status => 410
      end
    end
  end

   def renew_token
    @current_user.current_authentication.save! if @current_user
  end

end
