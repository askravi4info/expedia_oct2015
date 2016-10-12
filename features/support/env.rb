require 'rspec'
require 'page-object'

World(PageObject::PageFactory)

$production_url = 'www.expedia.com'
$qa_url = 'www.qa.expedia.com'