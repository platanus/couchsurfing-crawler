require 'spec_helper'

describe Login do

  it "should login", navigating: 'login', live: true do
    navigate user:"user@example.com", password: "12345"
    expect(browser.title).to eq('My Dashboard | Couchsurfing')
  end

end
