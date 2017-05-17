##
# Step definitions specific to the feature file 'example.feature' go here.
##
Given(/^I am on the Home screen$/) do
  @page = launch_to_home_page
end

Then(/^I should see "(.*?)"$/) do |expected_text|
  actual_text = @page.hello_world_text
  unless actual_text == expected_text
    raise "Saw #{actual_text} instead of #{expected_text}"
  end
end
