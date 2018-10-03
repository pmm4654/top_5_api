module ApiSearchesHelper
  def search_option(current_option)
    return 'desc' if current_option == 'asc'
    'asc'
  end
end