# SkyWatch
An app to allow users to share real-time weather updates

## Architecture
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

