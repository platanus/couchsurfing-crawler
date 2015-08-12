# Crawling couchsurfing.com

This repository is a thorough guide to creating an automated crawler using [Crabfarm](https://github.com/platanus/crabfarm-gem). By the end of it you will be able to get detailed information from a list of events related to a user registered on couchsurfing.com.

If you are looking for specific information try the [Crabfarm Documentation]().

## Install

Installing should be dead easy:

```
gem install crabfarm
npm install crabtrap -g
npm install phantomjs -g
```

And to generate the application:

```
crabfarm generate app my-couchsurfing-crawler
```

That should do it. If you run into any trouble installing please refer to the [Crabfarm repository]().

## Game plan

We want to make sure the crawler can enter the website otherwise it will not find the list of events and ideally using a system that allows us to retrieve data for different users.

The general steps to follow would be:

1. Login using specified user credentials
2. Browse to the events pages
3. Parse the events
4. Return usable data

All the while creating the tests necessary to make sure the code will return consistent results.

### Memento
First, we will save the portion of the website that we need in a local file. This is called a [memento](https://github.com/platanus/crabfarm-gem/wiki/memento) and it's a good idea for two main reasons:

* It's much faster and reliable to build a crawler if you don't depend on your internet connection.

* It makes it possible to know when and where to modify the crawler if the website changes by comparing a memento to the website source.

So let's go ahead and record one by running:

```
crabfarm record memento login
```

This will fire up your browser of choice ([by default](https://github.com/platanus/couchsurfing-crawler/blob/master/Crabfile#L72) it's Firefox). When it's ready visit the couchsurfing website and login using *any* valid credentials (input data is not stored hence they're are irrelevant) and when you're done just close the browser.

You should see a new file `spec/mementos/login.json.gz`.

Mementos are just a bundle of the pages and requests you made while recording. A barebones representation of what you did that will be used by Navigators. You don't have to worry about them too much.

### Navigator

Navigators are there to make sure we reach the page where an action will be performed. In this case first the login page and [later]() the events page.

To create a navigator run:

```
crabfarm generate navigator Login
```

If you're thinking *why is the navigator name capitalized and the memento is not?* that's because the navigator is a Ruby class. No? then maybe you're wondering what a navigator looks like, well this is it:

```ruby
class Login < Crabfarm::BaseNavigator
  def run
    # your awesome code goes here
    reduce_with_defaults
  end
end
```

Now almost every component in a Crabfarm application has a corresponding spec file. It's required that you add tests to your crawler and it's strongly recommended that you do it *before* you start programming each component. That way you have a good idea of what you want to end before you even start.

One simple yet effective way to know if it landed on the right page is looking inside the DOM for an element or text unique to that page. Try with the page title:

```ruby
describe Login do
  contexts "fresh start"
    it "navigates to the dashboard", navigating: 'login'
      navigate
      expect(browser.title).to eq('My Dashboard | Couchsurfing')
    end
  end
end
```

* `navigating` receives the name of the memento it should to use.

* `navigate` calls the navigator being described. This function will receive custom parameters if you define any (more on that [here]()).

* To put is simply `browser` is an interface to access the DOM. But it's much more, if you're curious see the [Pincers documentation]().

Everything else is just part of a regular test and naturally if you run it, it will fail. Let's fix that!

When thinking about navigators imagine that you're trying to guide someone to do what you need over the phone.

1. Go to website
2. Find link that says "Log in"
3. Type `jhon.doe@example.com` in the user field
4. Type `12345` in the password field
5. Click `Log In`

This is what that looks like in the navigator:

```ruby
class Login < Crabfarm::BaseNavigator
  def run
    browser.goto 'www.couchsurfing.com'
    browser.a(href: '/users/sign_in').click
    browser.text_field(name: 'user[login]').set('jhon.doe@example.com')
    browser.text_field(name: 'user[password]').set("12345")
    browser.input(value: "Log In").click
  end
end
```

As you can see `browser` is the corner stone of navigation. You can trigger events, set values and obtain them. If you're used to CSS/jQuery selectors it will be a breeze if not be sure to skim the [documentation]().

Now try running your tests again.
