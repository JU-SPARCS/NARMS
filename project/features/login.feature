Feature: Login
	 In order to make a connection
	 As a user
	 I want to be able to connect to the web site

Scenario: Login page
	  Given I am on the "login page"
	  When I fill in the following:
    	  |Email|atco@gmail.com|
          |Password|password|
	  And I press "submit"
	  Then I should see "Worker profiles:"