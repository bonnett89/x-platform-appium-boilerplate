# Appium World Class
class AppiumWorld
  def initialize(driver, page_factory)
    @driver = driver
    @page_factory = page_factory
  end

  def launch_to_home_page
    app_launch
    page = @page_factory.home_page_get
    page
  end

  def app_close
    @driver.close_app
  end

  def app_launch
    @driver.session_id
    @driver.launch_app
  rescue
    @driver.start_driver
  end

  def self.exit
    @driver.driver_quit
  end
end
