### Appium & Page Object Model

This project is built around using Cucumber with Appium and the Page Object Model, this has been implemented using a number of Support files. This document hopes to explain some of these.

#### env.rb

We use the `env` file to carry out a number of things. We set the file path of the `appium.txt` for the platform under test, and load this into a `caps` object using the `Appium.load_settings` method. We then create a new instance of a driver based upon these `caps`(capabilites). Next we use `Appium.promote_appium_methods` to make them available for use with out page objects.

The `World do` method is used to create a new instance of the `PageFactory` class passing both the platform under test and driver that we created earlier to it. We also create an instance of the `AppiumWorld` class again passing the driver, but also the newly created `page_factory` instance.

#### PageFactory

This class allows us to create instances of the pages and determine which ones should be instantiated based upon the platform under test. It also means that we can pass the `@driver` object to each class.

#### AppiumWorld

The `AppiumWorld` class is a custom world which acts as a page object for the app itself, allowing us to launch/close the app and start the driver. It allows access to high level helpers in the step definitions (see [Cucumber docs](https://github.com/cucumber/cucumber/wiki/A-Whole-New-World) for more info).

#### Adding a page

Lets say a new page has been added to the app. Lets call it the _buttons page_.

Firstly we add a method to our `AppiumWorld` class:
```ruby
def buttons_page_get
    @page_factory.buttons_page_get
end
```
So we are saying to the page factory to return the result of the method `buttons_page_get`:
```ruby
def buttons_page_get
    get_page_by_id('ButtonsPage')
end
```
This uses the `get_page_by_id` method to create a new instance of the class `IosButtonsPage`, this method has also passed the `@driver` for use with this class.

In one of the steps of our step definitions we could now call methods for this particular page by doing something like:
```ruby
@buttons_page = get_page_buttons_page
@buttons_page.buttons_page_title
```
This would return the title of that page.







.
