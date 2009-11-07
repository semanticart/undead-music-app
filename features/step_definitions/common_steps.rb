Given /^I am viewing "(.+)"$/ do |url|
  visit url
end

Given /^I have stubbed content for a last\.fm user$/ do
  @scrobbler = Scrobbler::User.new("violencenow")
  @scrobbler.stub!(:top_artists).and_return(LASTFM_SAMPLE[:top_artists])
  @scrobbler.stub!(:recent_tracks).and_return(LASTFM_SAMPLE[:recent_tracks])
  Scrobbler::User.stub!(:new).and_return(@scrobbler)
end

When /^I fill in "(.*)" with "(.*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I attach an iTunes library$/ do
  attach_file 'library', File.dirname(__FILE__)+ "/../../spec/iTunesLibrary.xml"
end

When /^I press "(.*)"$/ do |button|
  click_button(button)
end

Then /^I should see "(.+)"$/ do |text|
  response_body.should =~ Regexp.new(Regexp.escape(text))
end

Then /^I should not see "(.+)"$/ do |text|
  response_body.should_not =~ Regexp.new(Regexp.escape(text))
end

Then /^I should see an input named "([^\"]*)"$/ do |name|
  response_body.should have_tag("input[name=#{name}]")
end

Then /^I should see a link with text "([^\"]*)"$/ do |text|
  response_body.should have_tag("a", :content => text)
end


