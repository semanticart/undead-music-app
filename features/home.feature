Feature: Interactions on the home page

  Scenario: Finding last.fm artists
    Given I am viewing "/"
      And I have stubbed content for a last.fm user
     When I fill in "user" with "violencenow"
     When I press "Submit"
     Then I should not see "It should exist until we need to clear out some disk space."
     And  I should see a link with text "explosions in the sky"
     And  I should see a link with text "mogwai"

  Scenario: Finding iTunes artists
    Given I am viewing "/"
     When I attach an iTunes library
     And  I press "Upload Library"
     Then I should see "It should exist until we need to clear out some disk space."
     And  I should see a link with text "harvey danger"
