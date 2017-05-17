require_relative 'base_page'

# Base HomePage
class BaseHomePage < BasePage
  def initialize(platform, driver)
    @platform = platform
    @driver = driver
  end

  def home_page_title
    get_text(get_id(:home_page_title))
  end

  def hello_world_text
    get_text(get_id(:home_page_hello_world_text))
  end
end
