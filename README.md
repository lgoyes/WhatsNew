#  WhatsNew

## Author

Luis David Goyes Garces

## Description

With this app you'll be able to get the latest posts.

## Notes:

1. There are two possible configurations to work with: _Debug_ and _Release_. You should have the _Debug_ build configuration enabled during development, which would allow you to work without the concrete dependencies to the real network (i.e. URLSession) and the real database (i.e. CoreData). If you want to test the real depedencies, you should have the _Release_ build configuration enabled, instead.

The app on _Release_ mode will perform the actual requests to the api https://jsonplaceholder.typicode.com/ for the posts. If there is any network error, you will be informed so. On the same mode, the app will use an actual database. Data will persist through different initiations, though it will not persist through app installations.

The app on _Debug_ mode will use some stubs for both Network- and Database- repositories.

2. The app does not have any automated test.

3. Builds are not automated, since this application is for demonstrations purposes only.

## Architecture

The app has a domain-driven structure, with some views, some entities, some interactors and some repositories.

Repositories represent different data-sources, such as networking and local storage. Interactors represent the business-logic rules. Entities are the connection between views and interactors, and coordinate the interactor execution depending on events received from the presentation layer (user actions, or lifecycle events). Views just draw controls to the user and receive events.

Since views were built using SwiftUI, some state is required, to set a channel between the entity and the view.

## Contact

Feel free to issue any ticket to this repository, if you feel like reaching out.