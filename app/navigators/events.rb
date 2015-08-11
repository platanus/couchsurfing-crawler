class Events < Crabfarm::BaseNavigator

  def run
    browser.a(href: "/events").click
    browser.a(class: "cs-see-more").click

    reduce_with_defaults
  end

end
