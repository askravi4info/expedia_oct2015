@regression @HotelSearch
Feature: Verify the Flight Search Functionality

  Background:
    Given user is on expedia home page

  @smoke
  Scenario:Verify the user gets an error message when searching for Hotels for the past date
    And user should select the flights tab
    And user selects Columbus, OH (CMH airport for the city columbus from departure field
    And user selects Cleveland, OH (CLE airport for the city cleveland from arrival field
    And user makes a past date flight search
    And searches for the flights availability
    Then verify the "The start or end date is prior to the current date." error message is displayed