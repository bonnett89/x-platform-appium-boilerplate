# x-platform-appium-boilerplate
Cross platform example testing codebase for Appium

This is an example of how Appium can be used to test a cross platform application, albeit in this case a very very simple one.

## Prerequisites

The following dependencies will need to be installed first. Please follow their installation and set up guides.

- Ruby and RubyGems
- Node and npm

### Android
- Android Studio
- JDK
- Android SDK

### iOS
- Xcode 8+
- Xcode Command Line Tools
- iOS Simulators

You do not need both Android and iOS but will need which ever is relevant to the tests you are running.

Once above dependencies are added please run:
```sh
$ gem install bundler
$ bundle install
$ npm install
```
## Configuration

In the `config` folder you will find two additional folders: `android & ios`. These contain `appium.txt` capabilities files. Within these you wil need to edit the fields based up the configuration you have.

#### Example iOS:
```
[caps]
platformName="iOS"
deviceName="iPhone SE"
platformVersion="10.3"
automationName="XCUITest"
app="ios/HelloWorld.app.zip"
```
**deviceName** is the name of the simulator that you want to run on, to determine which ones you have installed you can run: `$ instruments -s devices` or open _Xcode > Window > Devices_ which will list the available simulators.

**platformVersion** is the version of iOS that will be running. This needs to be the same as the simulators on which you are running.

**automationName** this is only really applicable to iOS and newer flavours of iOS (Xcode 8+) it needs to be set to: `XCUITest`.

**app** is just a reference to where the app under test is located. You just need to make sure this points to the iOS app not an Android one.

### Running the tests

The first step needed is to build the example applications. Please follow the below steps for iOS:
- From the terminal run: `xcodebuild -showsdks`
This should list the sdk's you currently have available to build to. Select one with simulator in the name and note / copy this part: `-sdk iphonesimulator10.3`
- Now from terminal run: `xcodebuild -sdk iphonesimulator10.3`
This should build the project files to the following directory `/ios/build`, update your `appium.txt` to reflect the location of where the now build `.app` file is.

This project uses rake tasks to run the tests for iOS and Android. A list of available tasks can be seen by running: `rake --tasks`.

#### To run iOS tests:
```sh
$ rake ios_cucumber
```
This will first spin up an Appium server and then launch Cucumber. This test can take an additional argument passed by: `rake ios_cucumber[profile]`. Profiles can be set up for cucumber in the regular way by using the `cucumber.yml` file.

#### To run Android tests:
```sh
$ rake android_cucumber
```
This works exactly the same as the iOS tests above.

### Android Caveats
- An Android Virtual Device must be running before tests are started.
