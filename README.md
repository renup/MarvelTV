# Marvel Characters and Comics App

This is an iOS app built with SwiftUI that allows users to explore Marvel characters and comics. The app fetches data from the Marvel API and provides a user-friendly interface to browse and view details about characters and comics.

## Features

- View a list of Marvel characters with their names and thumbnails
- Tap on a character to see featured comics for that character
- Browse a list of Marvel comics with their titles, issue numbers, and thumbnails
- Error handling and user-friendly error messages for network and API-related issues

## More to come:
- Tap on a comic to view more information, such as description, release date, and characters featured in the comic
- Search functionality to easily find characters or comics by name
- Pagination support to load more characters or comics as the user scrolls

## Architecture

The app follows the MVVM (Model-View-ViewModel) architectural pattern, which provides a clear separation of concerns and enhances testability. The main components of the app are:

- **Models**: Represents the data entities used in the app, such as `Character` and `Comic`.
- **Views**: Defines the user interface of the app using SwiftUI views, such as `CharactersCollectionView` and `ComicsCollectionView`.
- **ViewModels**: Contains the business logic and manages the state of the views. Examples include `CharactersViewModel` and `ComicsViewModel`.
- **Services**: Handles network requests and communication with the Marvel API. The `NetworkTransport` is responsible for making API calls and parsing the responses.
- **Repositories**: Acts as an interface between the view models and the services. The `CharactersRepository` and `ComicsRepository` provide methods to fetch characters and comics data.

## Testing

The app includes a comprehensive suite of unit tests to ensure the correctness and reliability of the code. The tests cover various scenarios and edge cases, including:

- Testing the parsing and decoding of API responses
- Verifying the behavior of view models under different conditions
- Checking the error handling and state management in the view models
- Mocking network requests and responses to test the services and repositories

The unit tests are located in the `MarvelAppTests` target and can be run using the Xcode testing framework.

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/renup/marvel-app.git
   ```

2. Open the project in Xcode:
   ```
   cd marvel-app
   open MarvelTV.xcodeproj
   ```

3. Build and run the app in the iOS Simulator or on a physical device.

## Configuration

To run the app, you need to provide your own Marvel API keys. Follow these steps to configure the API keys:

1. Create a new file named `Secrets.swift` in the project.

2. Add the following code to `Secrets.swift`:
   ```swift
   struct Secrets {
       static let publicKey = "YOUR_PUBLIC_KEY"
       static let privateKey = "YOUR_PRIVATE_KEY"
   }
   ```

3. Replace `"YOUR_PUBLIC_KEY"` and `"YOUR_PRIVATE_KEY"` with your actual Marvel API keys.

Make sure to keep your API keys secure and do not commit the `Secrets.swift` file to version control.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
