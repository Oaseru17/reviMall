## General Information
Based on the demo project description the goal of the task is to create a simple E-commerce app.  The source code is developed in a way that highlights the following features:
- Simplicity 
- Testability 
- Readability
- Maintainability

## Features
- From my analysis, the following features are required:
- Product list (infinite scroll)
- Product details
- Cart
- Checkout

# Implementation Approach

### Architecture
**SWIFT UI**
The app is primarily built with SwiftUI, Async/Await, Opaque Types, Task, and Actors.

### Modular architecture
The app is designed with Modular architecture, While this can be considered over-engineering for this task, I decided to go on with it in a bid to highlight my experience with how source code grows over time and how if implemented from the start, Modular architecture makes it easier to manage source code (Maintainability), allow developers build in isolation. The modules create and their usage is listed below.

- **AboutDevModule:** A very simple module that houses the view and data required to present the information of the candidate.
- **NetworkingModule:** A module for all networking/API-related logic.
- **SharedUIModules:** Here all app reusable components that should be available to all modules are housed.
- **CartModule:** Here payment, cart presentation, and management logic are grouped and organized.
- **ProductListModule:** For product list and detail logic.
- **CoreModules:** This houses all business logic that is reusable between modules.

**MVVM** was primarily used within the app

Few Highlighted Designs applied
- Singleton
- Builder Pattern
- Protocol Oriented Programming
- Dependency Injection
- SOLID Principles
- DRY Principles
- XCConfigurations

### Accessibility 
iPhone is used by a wide range of users, and some users might have some form of disability. iPhone devices have strong support for a few forms of disability, for instance, the blind.  I introduced a few accessibility concepts into the application to improve these, a few can be found in **ProductDetailView**.

### Improvements
Improvements that could be added to improve the experience, include;
- **Offline Mode** using the Repository Pattern, this ensures that in an event of data connectivity loss, the app still provides a level of functionality.
- **Dark Mode**: The dark mode experience can be improved on
- **Localization**: String were used directly but localization should be applied as early as possible.
- **Animations**
- **Unit/UI Tests**: While unit tests can be found in **ProductList, Core & Cart modules**; UI tests are in the base app module. Within the time frame, a number of tests were written but this can be improved to cover more scenarios.
- **Sticky cart**: No database was implemented both locally or remotely. This can be easily introduced based on the Repository Pattern implemented

