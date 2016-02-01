Feature: like and unlike a movie
  
  As a movie enthusiast
  So upvote a movie or unvote on a movie
  I want to be able to like or unlike it
  
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

Scenario: like a movie
  Given I am logged in as "test1@me.me"
  When  I go to the details page for "Alien"
  And   I follow "Like"
  Then  I should see "LIKED ALIEN!!!"
  
Scenario: unlike a movie
  Given I am logged in as "test1@me.me"
  When  I go to the details page for "Alien"
  And   I follow "Like"
  And   I follow "Unlike"
  Then  I should see "Vote deleted" 