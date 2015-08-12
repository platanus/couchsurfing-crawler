require "date"
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
    event.link        = build_url(html.at_css(".card__title a").attribute("href"))
    event.location    = parse_location(html.at_css(".card__location").text)
    event.date        = parse_date(html.at_css(".event__date").text)
    event.attendance  = parse_attendance(html.at_css(".event__attendance").text)
    event.image_url   = html.at_css(".card__image img").attribute("src")
    event
  end

  def parse_date(date_string)
    DateTime.parse(date_string)
  end

  def parse_attendance(attendance_string)
    attendance_string.split(" ")[0].to_i
  end

  def parse_location(location_string)
    parts = location_string.split(", ")
    location = {}

    [:country, :region, :commune, :city, :address, :place].each do |key|
      location[key] = parts.pop || ""
    end

    location
  end

  def build_url(relative_url)
    "https://www.couchsurfing.com" + relative_url
  end

end
