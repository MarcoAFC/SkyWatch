# SkyWatch
An app to allow users to share real-time weather updates

## First steps

To get the app running a few things will be necessary:

First and foremost an up-to-date Flutter environment, using an SDK higher than 3.1.0. At the time of development, flutter version 3.13.4 was used.

Next, support is given to both Android and iOS platforms, meaning a compatible device running one of those is necessary. Since regular distributions usually follow simpler means,
this documentation won't go in depth on how to properly set up your system.

Further info on how to install and setup flutter is available [here](https://docs.flutter.dev/get-started/install).

And last but not least, this app has a simple two-page structure: your home page will quickly show available cities, and the search icon allows you to find any available place, and clicking a card will redirect you to a more detailed page containing current weather and forecast for the next 5 days.

Enjoy!

## Running
### App
To run the app, consider all that was said above, and with a running Android device or emulator, execute in your terminal

```
flutter pub get
flutter run
```


### Tests
Again, considering a valid structure is available, execute in your terminal:

```
flutter pub get
flutter test
```

## Technical details
### Architecture
This app was built with a clean architecture based format, with some changes to make it simpler.

Conceptually, the objective is to reduce unnecessary ties between different layers of implementation, to
allow easier replacement of pieces of code since they are, essentially, standalone.

To achieve this, the app was built using the following structure:

#### Data
In this layer, any calls to external sources will be made, be they API or local storage calls. 

Transforming data to and from json/map formats is a responsability of this layer.

#### Infra
The infrastructure layer is mostly responsible for controlling the details of which datasource should be invoked,
in cases when local and remote (or even several remote) datasources exist. Over here we can also parse exceptions 
thrown by datasources to make sure it generates something that is user-readable and that doesn't expose too much
possibly sensitive information.

#### Domain
Over here, our entities, representing the pure state of our data will be placed, along with usecases to allow
acess to data-side layers from the view. 

#### Presentation
And finally, the presentation layer is in charge of building the UI itself in the form of pages, controlling and 
invoking data related queries through the controllers. 

### Other elements
- Dependecy injection was built using GetIt.

- State Management was made using Bloc.

- Mocktail was used for mocking dependencies in unit tests.

