# TypiCodeImages
An iOS app challenge to display a list of images download from http://jsonplaceholder.typicode.com/photos.

#### Project Functionality and assumptions
  - The app sorts the downloaded images into a album based dictionary. On UI each album represents a section and then images are shown under it.
    ---- add an image here

  - The Collection view on the landing screen has a pull to refresh feature. Upon pulling the app makes a fresh web-service call to download the latest data.

  - Tapping on any of the image takes user to the detail view.
  ---- add an image here

  - Its a pretty small application and the data is not mutated throughout the app lifecycle so no datastore is used.

  - App uses a basic in-memory cache implementation to reduce overhead of downloading images over the network again and again. In real life apps, a disc cache might be a prefrential option so that the downloaded images could be used across the sessions. But this would also require a machenism (i.e. LRU or similar) to clean-up the space for obsolete images.
  - The app supports orientation changes.

#### Design Approach
  1. The project uses **Model-View-View-Model** design approach with **Flow-Coordinators** used for routing.

  2. The app uses **Protocol Oriented Design**, which provides nice decoupling between different components and allow for writing deterministic unit test cases.

  3. Through the app I tried to **Limit the mutability and side effects**. The app limits the use of `class` and uses `structs` and `enums` wherever possible. Also use `let` instead of `var`.

  4. The app is divided into different modules to have **Separation of concerns**. For instance, `NetworkProtocol` only had a **Single responsibility** to make network calls on behalf of caller and return data.

  5. The app is written in **Reactive programming** style.

  6. The app uses **Dependency injection** to

***Testing and unit Test***



***Open source libraries used***

  1. RxSwift / RxCocoa
  2. Swinject
  3. SnapKit
  4. Moya
  5. SwiftGen

  **For testing**
  1. Nimble
  2. Quick
  3. Cuckoo
