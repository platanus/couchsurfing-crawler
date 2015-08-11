require 'spec_helper'

describe Events do

  before do
    navigate :login, user:"user@example.com", password: "12345"
  end

  let!(:reducer) {spy_reducer EventsReducer}

  it "go to events page", navigating: 'events', live: true do
    navigate
    expect(browser.title).to eq('Event Search | Couchsurfing')
  end

end
