class ApiSearchesController < ApplicationController

  def index
    @api_searches = ApiSearch.all
  end

end
