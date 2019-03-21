# TypiCodeImages
An iOS app challenge to display a list of images download from http://jsonplaceholder.typicode.com/photos.

### Project Functionality and assumptions
  - The app sorts the downloaded images into a album based dictionary. On UI each album represents a section and then images are shown under it.
    ---- add an image here

  - The Collection view on the landing screen has a pull to refresh feature. Upon pulling the app makes a fresh web-service call to download the latest data.

  - Tapping on any of the image takes user to the detail view.
  ---- add an image here

  - Its a pretty small application and the data is not mutated throughout the app lifecycle so no datastore is used.

  - App uses a basic in-memory cache implementation to reduce overhead of downloading images over the network again and again. In real life apps, a disc cache might be a preferential option so that the downloaded images could be used across the sessions. But this would also require a mechanism (i.e. LRU or similar) to clean-up the space for obsolete images.
  - The app supports orientation changes.

### Possible Improvements
  - The app could have a page view style implementation on the detail view, so user could slide left or right to see other images.

  - The app could have some integration tests, while unit test coverage of the app is pretty good, but we could have tested how different components work together.


### Design Approach
  1. The project uses **Model-View-View-Model** design approach with **Flow-Coordinators** used for routing.

  2. The app uses **Protocol Oriented Design**, which provides nice decoupling between different components and allow for writing deterministic unit test cases.

  3. Through the app I tried to **Limit the mutability and side effects**. The app limits the use of `class` and uses `structs` and `enums` wherever possible. Also use `let` instead of `var`.

  4. The app is divided into different modules to have **Separation of concerns**. For instance, `NetworkProtocol` only had a **Single responsibility** to make network calls on behalf of caller and return data.

  5. The app is written in **Reactive programming** style.

  6. The app uses **Dependency injection** to decouple the implementation of different components. This improved re-usability and allow for writing targeted unit test cases.

### Testing and unit Test
  The app has an extensive test coverage for the functionality it provides. The parts where we have most of the logic, i.e `APiClient`, `NetworkProvider`, `Cache`, `viewModel's` and `utility` classes. Current code coverage is at **70.6%** percent, this can also be improved slightly if we'll exclude View components from coverage computation.

  The app also has an ability to mock the responses locally, just change the input value of `MoyaNetworkImplementation` to `.stubbed` in `DependencyConfigurator.swift` and the app would run via a locally provided sample json and images. This technique is specially useful in writing deterministic integration tests where you can control the input parameters to the program and see output with different conditions.


### Open source libraries used

  1. RxSwift / RxCocoa
  2. Swinject
  3. SnapKit
  4. Moya
  5. SwiftGen
  6. NVActivityIndicatorView

  **For testing**
  1. Nimble
  2. Quick
  3. Cuckoo
