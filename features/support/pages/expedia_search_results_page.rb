class ExpediaSearchResultsPage
  include PageObject

  span(:results_title, :class => 'title-city-text')
  spans(:price, class: 'dollars price-emphasis bestValue-emphasis bestValueDetails-emphasis')
  div(:search_filter, id: 'filterContainer')
  div(:progress, class: 'progress-bar')


  def wait_for_page_to_load
    wait_until(45, "Search Filter has not loaded with in 45sec") {
      search_filter_element.visible?
      progress_element.div_element.element.attribute_value('style').include? 'width: 100'
    }
  end

  def get_results_title
    wait_for_page_to_load
    results_title
  end

  def get_price_details
    all_prices = []
    wait_for_page_to_load
    # price_elements.map(&:text)
    price_elements.each do |price|
     all_prices << price.text[1..-1].gsub(',',"").to_i
    end
     all_prices

  end

end