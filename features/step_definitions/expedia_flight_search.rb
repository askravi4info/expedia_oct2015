Given(/^user is on expedia home page$/) do
  visit ExpediaHomePage
end

And(/^user should select the flights tab$/) do
  on(ExpediaHomePage).select_flight_tab_element.click
end

And(/^user selects (.+) airport for the city (.+) from (arrival|departure) field$/) do |airport_name, city_name, dep_arr|
  # if dep_arr == 'departure'
  #   on(ExpediaHomePage).set_departure_details city_name, airport_name
  # else
  #   on(ExpediaHomePage).set_arrival_details city_name, airport_name
  # end

  on(ExpediaHomePage).send("set_#{dep_arr}_details", city_name, airport_name)
  # on(ExpediaHomePage).send("#{dep_arr}_airport_element").set 'columbus'

end


And(/^user makes a (past|future) date flight search$/) do |past_future|
  on(ExpediaHomePage) do |page|
    if past_future == 'past'
      page.set_dep_arr_dates -2, 3
    else
      page.set_dep_arr_dates 2, 3
    end
  end
end

And(/^searches for the flights availability$/) do
  on(ExpediaHomePage).search_button_element.click
end

Then(/^verify the "([^"]*)" error message is displayed$/) do |error_message|
  on(ExpediaHomePage).verify_error_message error_message
end

Then(/^verify the flight search results (.*) is displayed correctly$/) do |expected_msg|
  # on(ExpediaSearchResultsPage).wait_until {on(ExpediaSearchResultsPage).results_title_element.visible?}

  # on(ExpediaSearchResultsPage).wait_for_page_to_load
  # actual_msg = on(ExpediaSearchResultsPage).results_title

  actual_msg = on(ExpediaSearchResultsPage).get_results_title
  fail "#{actual_msg} is not same as #{expected_msg}" unless actual_msg == expected_msg
end

And(/^user search for a future valid flights$/) do
  on(ExpediaHomePage) do |page|
    page.select_flight_tab_element.click
    page.set_departure_details 'columbus', 'Columbus, OH (CMH'
    page.set_arrival_details 'cleveland', 'Cleveland, OH (CLE'
    page.set_dep_arr_dates 2, 3
    page.search_button_element.click
  end
end

Then(/^verify the search results are displayed by price$/) do
  expected_price = on(ExpediaSearchResultsPage).get_price_details
  p expected_price
  fail "#{expected_price} is not same as #{expected_price.sort}" unless expected_price == expected_price.sort
end

When(/^I load and read the yml files$/) do
  on(ExpediaHomePage).load_data_yml
  fail "Failed Explicitly"
end

Then(/^verify the following error message are displayed$/) do |table|
  # table is a table.hashes.keys # => [:error_messages, :dates]
  table.hashes.each do |message|
    p message['error_messages']
    p message['dates']
    on(ExpediaHomePage).verify_error_message message['error_messages']
  end
end