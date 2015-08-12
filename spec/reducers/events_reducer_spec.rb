require 'spec_helper'

describe EventsReducer do

  it "should return the events", reducing: 'events', live: true do
    expect(reducer.events).not_to be_empty
  end

  it "should parse event title", reducing: 'events', live: true do
    expect(reducer.events[1].title).to eq('SPANGLISH PARTY')
  end

  it "should parse event url", reducing: 'events', live: true do
    expect(reducer.events[2].link).to eq('https://www.couchsurfing.com/events/ecosonorisacion-pot-luck')
  end

  it "should parse event location", reducing: 'events', live: true do
    expect(reducer.events[3].location).to eq({
      country: "Chile",
      region: "Región Metropolitana",
      commune: "Providencia",
      city: "Santiago",
      address: "Santa Isabel 664",
      place: "El Shack"
    }.to_s)
  end

  it "should parse event date", reducing: 'events', live: true do
    expect(reducer.events[0].date).to eq(DateTime.parse('Sat, Dec 12 at 11:00 AM CLST').to_s)
  end

  it "should parse event attendance", reducing: 'events', live: true do
    expect(reducer.events[4].attendance).to eq(10)
  end

  it "should parse event image url", reducing: 'events', live: true do
    image_url = "https://tcdn.couchsurfing.com/KrSCtcT5ICt3qPnZUvV4x-c9mbE=/80x80/smart/https://s3.amazonaws.com/images.couchsurfing.com/083/311/000311083/d0bd655670b965d5f96689b65832c105"

    expect(reducer.events[6].image_url).to eq(image_url)
  end

end
