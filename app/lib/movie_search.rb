class MovieSearch
  attr_reader :last_search, :search_input
  attr_accessor :response_data
  def initialize(last_search)
    @last_search = last_search
    @search_input = last_search.user_input
    @response_data ||= cache_results
  end

  def cache_results
    self.response_data = Rails.cache.fetch("api_search/#{search_input}") do
      _api_response = RestClient.get("http://www.omdbapi.com/?t=#{search_input}&apikey=#{ENV.fetch('OMDB_API_KEY', nil)}")
      {body: JSON.parse(_api_response.body), user_input: search_input}
    end
  end

end