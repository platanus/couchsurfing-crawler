require 'spec_helper'

describe EventsReducer do

  it "should return the events", reducing: 'events', live: true do
    expect(reducer.events).not_to be_empty
  end

  it "should parse event title", reducing: 'events', live: true do
    expect(reducer.events[0].title).to eq('Defqon.1 Chile')
  end

  it "should parse event url", reducing: 'events', live: true do
    expect(reducer.events[0].link).to eq('/events/defqon-1-chile')
  end

  it "should parse event location", reducing: 'events', live: true do
    expect(reducer.events[0].location).to eq('Santiago, Santiago, Santiago Metropolitan Region, Chile')
  end

  it "should parse event date", reducing: 'events', live: true do
    expect(reducer.events[0].date).to eq('Sat, Dec 12 at 11:00 AM CLST')
  end

  it "should parse event attendance", reducing: 'events', live: true do
    expect(reducer.events[0].attendance).to eq('26 attending')
  end

  it "should parse event image url", reducing: 'events', live: true do
    expect(reducer.events[0].image).to eq('https://tcdn.couchsurfing.com/OC_9DmW3pSG-LSiP6emedKxFIBU=/80x80/smart/https://s3.amazonaws.com/ht-images.couchsurfing.com/u/1006424028/33b287ae-6048-49c9-a98e-e4c37a62c396')
  end

end
