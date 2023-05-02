# README

## Overview
This project is a Flutter application that uses Riverpod for state management and dependency injection, Clean Architecture for the project structure, Fake Store API for data retrieval, and Dio for network communication.

## Requirements
To run this project, you need to have the following software installed on your machine:
- Flutter (3.7.12 - Stable)
- Dart ('>=2.19.6 <3.0.0')

## Installation
1. Clone the repository to your local machine.
2. Open the project in your preferred IDE.
3. Run `flutter pub get` to install the required dependencies.

## Usage
You can run the project on either an emulator or a physical device using the command `flutter run`.

## Project Structure
The project uses Clean Architecture, which separates the code into layers: Presentation, Domain, and Data. Each layer has its own responsibility and is independent of the other layers.

The project structure is as follows:

```
.
└── lib/
    ├── src/
    │   ├── core/
    │   │   ├── base
    │   │   └── network
    │   └── feature/
    │       └── product/
    │           ├── details/
    │           │   ├── data/
    │           │   │   └── models
    │           │   ├── domain/
    │           │   │   └── use_cases
    │           │   └── presentation/
    │           │       ├── pages
    │           │       └── riverpod
    │           ├── products/
    │           │   ├── data/
    │           │   │   └── models
    │           │   ├── domain/
    │           │   │   ├── repositories
    │           │   │   └── use_cases
    │           │   └── presentation/
    │           │       ├── pages
    │           │       └── riverpod
    │           └── root/
    │               └── data/
    │                   ├── data_sources
    │                   └── repositories
    └── main.dart
```
## Dependencies
- flutter_riverpod: 2.3.6
- dio: 5.1.1
- dartz: 0.10.1

## Feature
- Fetching all products and categories
- Filtering fetched products by category locally
- Fetching product details and caching the response
- Improving performance of ListView by using *overrideWithValue* and passing const widget
- Navigation using GoRouter

## Dependency Injection, State Management & Caching
The project uses Riverpod for both state management and dependency injection. It allows for easy management of dependencies and makes it easier to test the code. By combining ```FutureProvider.autoDispose``` with ```keepAlive``` caching is also acheieved. 

## Network Communication
The project uses Dio for network communication, which is a powerful HTTP client for Dart. It makes it easy to make network requests and handle responses.

## Data Retrieval
The project uses the Fake Store API for data retrieval. This is a fake e-commerce API that provides product data that can be used for testing and demonstration purposes.

## Conclusion
This project is an example of how to use Flutter, Riverpod, Clean Architecture, Fake Store API, and Dio together to create a robust and maintainable application.
