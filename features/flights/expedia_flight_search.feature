@regression @FlightSearch
Feature: Verify the Flight Search Functionality

  Background:
    Given user is on expedia home page

  @slow
  Scenario:Verify the user gets an error message when searching for past flights
    And user should select the flights tab
    And user selects Columbus, OH (CMH airport for the city columbus from departure field
    And user selects Cleveland, OH (CLE airport for the city cleveland from arrival field
    And user makes a past date flight search
    And searches for the flights availability
    Then verify the "The start or end date is prior to the current date." error message is displayed

  @smoke @one_way @flight @fl_0038
  Scenario Outline:Verify the user finds the correct departure flight details
    And user should select the flights tab
    And user selects <dep_airport> airport for the city <dep_city_name> from departure field
    And user selects <arr_airport> airport for the city <arr_city_name> from arrival field
    And user makes a future date flight search
    And searches for the flights availability
    Then verify the flight search results <results_msg> is displayed correctly
  Examples:
    | dep_city_name | dep_airport        | arr_city_name | arr_airport        | results_msg                        |
    | columbus      | Columbus, OH (CMH  | cleveland     | Cleveland, OH (CLE | Select your departure to Cleveland |
    | cleveland     | Cleveland, OH (CLE | columbus      | Columbus, OH (CMH  | Select your departure to Columbus  |

  @smoke
  Scenario:Verify the sort order of the search results are by price
    And user search for a future valid flights
    Then verify the search results are displayed by price

  Scenario:Verify different error messages when searching for past flights
    And user should select the flights tab
    And user makes a past date flight search
    And searches for the flights availability
    Then verify the following error message are displayed
      | error_messages                                      | dates  |
      | The start or end date is prior to the current date. | past   |
      | Please complete the highlighted origin field below. | future |

  @manual
  Scenario: verify the look and feel of the Expedia home page
    Given user is on expedia home page
    Then veirify the look and feel of the page is same as the wireframes

  Scenario: testing the yml files
    When I load and read the yml files