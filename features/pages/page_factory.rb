# Page Factory Class
class PageFactory
  def initialize(platform, driver)
    @platform = platform
    @driver = driver
  end

  def home_page_get
    get_page_by_id('HomePage')
  end

  def get_page_by_id(page_name)
    case @platform
    when 'android'
      Object.const_get("Android#{page_name}").new(@platform, @driver)
    when 'ios'
      Object.const_get("Ios#{page_name}").new(@platform, @driver)
    end
  end
end
