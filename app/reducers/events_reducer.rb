require "pry"

class EventsReducer < Crabfarm::BaseReducer
  has_field :events

  def run
    self.events = event_list.map{ |e| parse(e) }
  end

  def event_list
    @event_list ||= css(".event-item")
  end

  def parse(html)
    event = Event.new
    event.title       = html.at_css(".card__title").text
    event.link        = html.at_css(".card__title a").attribute("href")
    event.location    = html.at_css(".card__location").text
    event.date        = html.at_css(".event__date").text
    event.attendance  = html.at_css(".event__attendance").text
    event.image       = html.at_css(".card__image img").attribute("src")
    event
  end

end
