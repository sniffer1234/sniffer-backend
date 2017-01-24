class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  respond_to :json

  def pagination_dict(object, extra_meta = {})
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page, # use object.previous_page when using will_paginate
      total_pages: object.total_pages,
      total_count: object.total_count
    }.merge(extra_meta)
  end
end
