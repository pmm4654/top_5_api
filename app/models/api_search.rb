class ApiSearch < ApplicationRecord
  scope :with_versions, -> do 
    select('api_searches.id, api_searches.user_input, COUNT(versions.id) as version_count')
      .joins(:versions)
      .group('api_searches.id')
  end

  scope :top_5_searches, -> { with_versions.limit(5).order('version_count desc') }
  has_paper_trail
end
