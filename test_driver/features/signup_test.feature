Feature: signup link redirects to signup page
  Scenario: when signup is tapped
    Given I have 'signup' link
    When I tap 'signup'  link
    Then I should see 'SignupOption' on screen
    
