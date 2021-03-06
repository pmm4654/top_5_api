class ApiSearchesController < ApplicationController
  before_action :set_top_5_api_searches, only: [:index]

  def index
  end

  def create
    api_search_tracker = ApiSearchLogger.new(ApiSearch, params[:api_search][:user_input])
    if api_search_tracker.log_search!
      render_js_results(api_search_tracker)
    else
      redirect_with_error
    end
  end

  private
    def set_top_5_api_searches
      @api_searches = ApiSearch.top_5_by_count unless params[:search_count_sort] || params[:user_input_sort]
      @api_searches = ApiSearch.top_5_by_count(params[:search_count_sort]) if params[:search_count_sort]
      @api_searches = ApiSearch.top_5_by_search_term(params[:user_input_sort]) if params[:user_input_sort]
    end

    def render_js_results(api_search_tracker)
      respond_to do |format|
        @search_results = MovieSearch.new(api_search_tracker.last_search)        
        set_top_5_api_searches
        format.js
      end
    end

    def api_search_params
      params.require(:api_search).permit(:user_input)
    end

    def redirect_with_error
      set_top_5_api_searches
      redirect_to '/', notice: t('api_searches.index.could_not_save_result')
    end
end
