class ApiSearch < ApplicationRecord
  scope :with_versions, -> do 
    select('api_searches.id, api_searches.user_input, COUNT(versions.id) as version_count')
      .joins(:versions)
      .group('api_searches.id')
  end

  scope :top_5_searches, -> { with_versions.limit(5) }

  scope :top_5_by_count, -> (direction = 'desc') do 
    top_5_searches.order("version_count #{direction}")
  end

  scope :top_5_by_search_term, -> (direction = 'desc') do 
    top_5_searches.order("user_input #{direction}")
  end

  has_paper_trail
end
