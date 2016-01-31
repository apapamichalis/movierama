Feature: filter movies by uploader
  
  As a movie enthusiast
  So that I can view movies of the same uploader 
  I want to be able to filter the movie list
  
Background: movies in database
 
  Given the following movies exist:
  | title         | text    | created_at |  user_id |
  | Terminator    | blah    | 2016-01-25 |  1       |
  | Blade Runner  | blah    | 2016-01-20 |  1       |
  | Alien         | blah    | 2015-12-25 |  1       |
  | pi            | blah    | 2005-04-29 |  2       |
  
  Given the following users exist:
  | name      | email       | password  | id  |
  | test1     | test1@me.me | 12345678  | 1   |
  | test2     | test2@me.me | 12345678  | 2   |
 
   And I am on the MovieRama home page
   
Scenario: filter movies by uploader
  When  I follow "test2"
  Then  I should see the movie "pi" with description "blah"
  And   I should not see the movie "Alien"