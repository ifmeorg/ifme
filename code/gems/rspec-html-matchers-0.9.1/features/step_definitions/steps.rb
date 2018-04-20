Given /^I have following template:$/ do |string|
  File.open($INDEX_HTML,'w+') do |file|
    file.write(string)
  end
end

When /^I open this template in browser$/ do
  visit('/index.html')
end

Then /^I should be able to match static content$/ do
  # capybara:
  expect(page).to have_content('Hello World!')
  expect(page).to have_css('h1')

  # rspec-html-matchers:
  expect(page).to have_tag('h1', :text => 'Hello World!')
end

Then /^I should be able to match javascript generated content$/ do
  # capybara:
  expect(page).to have_content('Hello Another World!')
  expect(page).to have_css('p')

  # rspec-html-matchers:
  expect(page).to have_tag('p', :text => 'Hello Another World!')
end
