# Base Page Class
class BasePage
  def initialize(platform, driver)
    @platform = platform
    @driver = driver
  end

  def ids
    raise 'Unsure what this is here for'
  end

  def get_id(id)
    element_id = ids[id]
    element_id
  end

  def element(id)
    @driver.find_element(id: id)
  end

  def get_text(id)
    element(id).text
  end
end
