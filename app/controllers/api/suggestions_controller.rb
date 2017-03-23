class Api::SuggestionsController < Api::BaseController

  # POST /api/suggestions
  def create
    @suggestion = Suggestion.new(suggestion_params)

    unless @suggestion.save
      return render :json => { :error => { :code => 422, :description =>  @suggestion.errors.full_messages } }, :status => 422
    end

    # Send an email
    SuggestionMailer.notify(@suggestion).deliver_now

    # Finish request
    render json: {}
  end

  private

  def suggestion_params
    params.require(:suggestion)
          .permit(:content)
          .merge(user_id: @current_user.id)
  end
end
