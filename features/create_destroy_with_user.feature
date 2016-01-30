Feature: add, update or delete a movie
  
  As a movie enthusiast
  So that I can modify the list of movies
  I want to be able to add, update or delete a movie
  
Background: movies in database
 
  Given the following movies exist:
  | title         | text    | created_at |  user_id |
  | Terminator    | blah    | 2016-01-25 |  1       |
  | Blade Runner  | blah    | 2016-01-20 |  1       |
  | Alien         | blah    | 2015-12-25 |  2       |
  | pi            | blah    | 2005-04-29 |  2       |
  
  Given the following users exist:
  | name      | email       | password  | id  |
  | test1     | test1@me.me | 12345678  | 1   |
  | test2     | test2@me.me | 12345678  | 2   |

Scenario: add a new movie
  Given I am logged in as "test2@me.me"
  And   I am on new movie page
  When  I fill in "Title" with "Django"
  And   I fill in "Description" with "A western..."
  And   I press "Save Changes"
  Then  I should see the movie "Django" with description "A western..."
  
Scenario: update a movie as the creator
  Given I am logged in as "test2@me.me"
  When  I go to the edit page for "Alien"
  And   I fill in "Description" with "updating for testing purposes"
  And   I press "Save Changes"
  Then  I should see the movie "Alien" with description "updating for testing purposes"
  
Scenario: try to update a movie that does not belong to me
  When I am logged in as "test1@me.me"
  And  I go to the edit page for "Alien"
  And  I fill in "Description" with "updating for testing purposes"
  And  I press "Save Changes"
  Then I should see "Only the creator of a movie can edit it"
  
Scenario: delete a movie
  When I am logged in as "test2@me.me"
  And  I go to the details page for "Alien"
  And  I follow "Delete Movie"
  Then I should not see "Alien"
  And  I should see "Blade Runner"
  
  