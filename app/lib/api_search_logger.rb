class ApiSearchLogger
  attr_reader :user_input, :model_class
  attr_accessor :last_search
  def initialize(model_class, user_input)
    @model_class = model_class
    @user_input = user_input
    @last_search ||= model_class.includes(:versions).find_by(user_input: user_input)
  end

  def log_search!
    return last_search.touch if is_duplicate_search?
    create_new_search! if last_search.blank?
  end

  private

  def create_new_search!
    new_search = model_class.new(user_input: user_input)
    if new_search.save
      self.last_search = new_search
      new_search
    else
      raise 'Search could not be saved'
    end
  end

  def is_duplicate_search?
    @is_duplicate_search ||= last_search.present?
  end

end