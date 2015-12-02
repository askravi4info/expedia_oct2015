class ExpediaHomePage
  include PageObject

  page_url 'www.expedia.com'

  link(:select_flight_tab, :id => 'tab-flight-tab')
  text_field(:departure_airport, :id => 'flight-origin')
  text_field(:arrival_airport, :id => 'flight-destination')
  ul(:list_of_airports, :class => 'results')
  text_field(:departure_date, :id => 'flight-departing')
  text_field(:arrival_date, :id => 'flight-returning')
  button(:search_button, :id => 'search-button', :type => 'submit')
  div(:error_messages, :id => 'flight-errors')


  def set_departure_details city_name, airport_name
    self.departure_airport = city_name
    departure_airport_element.send_keys :end
    select_correct_airport(airport_name)
  end

  def set_arrival_details city_name, airport_name
    self.arrival_airport = airport_name
    arrival_airport_element.send_keys :end
    select_correct_airport(airport_name)
  end

  def select_correct_airport(airport_name)
    list_of_airports_element.when_visible.list_item_elements.each do |airport|
      if airport.text.include? airport_name
        p "#{airport.text} - SELECTED"
        airport.click
        break
      end
    end
  end

  def set_dep_arr_dates dep_date, arr_date
    dep_date = (Time.now+60*60*24*dep_date).strftime("%m/%d/%Y")
    arr_date = (Time.now+60*60*24*arr_date).strftime("%m/%d/%Y")

    self.departure_date = dep_date
    self.arrival_date = arr_date
  end

  def select_search_button
    search_button_element.click
  end

  def verify_error_message error_message
    fail "#{error_message} does not exists" unless error_messages_element.text.include? error_message
  end

  def load_data_yml
    @file = YAML.load_file('features/test_data.yml')
    p @file.fetch('request')

    p @file['airport_name']
    p @file['content']['session']

    File.open('features/test_data.yml', "w") { |f|

    @file['request'] = 33333
    @file['content']['session'] = 3 #Modify

    f.write(@file.to_yaml) }

    p @file.fetch('request')
    p @file['content']['session']
  end

end