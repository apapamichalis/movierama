Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == nil
    uncheck = ""
  end
  rating_list.split(", ").each do |rating|
    step "I " << uncheck << "check \"ratings_#{rating}\""
  end
end

Then(/^I should see all of the movies$/) do
  # Make sure that all the movies in the app are visible in the table
  all("table#movies tr").count.should == 11
  #fail "Unimplemented"
end


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.index(e1).should < page.body.index(e2)
  
  #fail "Unimplemented"
end

Then /I should see the movie "(.*)" with description "(.*)"/ do |title, description|
  page.should have_content(title) and page.should have_content(description)
end