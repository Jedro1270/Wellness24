Feature: signup link redirects to signup page
  Scenario: when signup is tapped
    Given i have 'signup'
    When i tap 'signup' 
    Then i should see 'SignupOptions' on screen
    
