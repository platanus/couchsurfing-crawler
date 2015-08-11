class Login < Crabfarm::BaseNavigator

  def run
    browser.goto 'www.couchsurfing.com'

    browser.a(href: '/users/sign_in').click
    browser.text_field(name: 'user[login]').set(params[:user])
    browser.text_field(name: 'user[password]').set(params[:password])
    browser.input(value: "Log In").click

    {} # bugfix
  end

end
