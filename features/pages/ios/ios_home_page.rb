require_relative '../home_page'

# iOS homepage class
class IosHomePage < BaseHomePage
  def ids
    {
      home_page_title: 'home_screen',
      home_page_hello_world_text: 'HelloWorldLabel'
    }
  end
end
