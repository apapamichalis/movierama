Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.index(e1).should < page.body.index(e2)
end

Then /I should see the movie "(.*)" with description "(.*)"/ do |title, description|
  page.should have_content(title) and page.should have_content(description)
end

Then(/^I should not see the movie "([^"]*)"$/) do |title|
  page.should_not have_content(title)
end