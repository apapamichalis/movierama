Feature: display list of movies sorted by different criteria
 
  As an avid moviegoer
  So that I can quickly browse movies based on my preferences
  I want to see movies sorted by the order they were added

Background: movies have been added to database
  
  Given the following movies exist:
  | title         | text    | created_at |
  | Terminator    | blah    | 2016-01-25 |
  | Blade Runner  | blah    | 2004-01-20 |
  | Alien         | blah    | 2015-12-25 |
  | pi            | blah    | 2005-04-29 |

  And I am on the MovieRama home page

Scenario: sort movies by date
  When I follow "Most Recent"
  Then I should see "Terminator" before "Alien"
  And  I should see "pi" before "Blade Runner"
  # your steps here

#Scenario: sort movies in increasing order of release date
 # When I follow "Release Date"
  #Then I should see "2000-06-21" before "2004-11-05"
  # your steps here
