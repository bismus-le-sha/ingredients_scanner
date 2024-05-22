# Ingredients Scanner

## Overview
Ingredients Scanner is a cross-platform mobile application designed to scan and interpret the ingredient lists on food labels. It enhances readability and assists users in identifying undesirable ingredients.

## Features
- **Text Recognition**: Utilizes Google ML Kit for text recognition.
- **User Authentication**: Powered by Firebase Authentication.
- **User Preferences**: Stores user settings using SharedPreferences.
- **Clean Architecture**: Adheres to clean architecture principles.
- **TDD Approach**: Developed using Test-Driven Development (TDD).

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase account

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/spermobak/ingredients_scanner.git
   
2. Navigate to the project directory:
   ```sh
   cd ingredients_scanner

3. Install dependencies:
   ```sh
   flutter pub get

### Firebase Setup
Add your 'google-services.json' (for Android) and 'GoogleService-Info.plist' (for iOS) to the respective directories.

### Running the App
1. Run the app on an emulator or connected device:
   ```sh
   flutter run

## Architecture
- **Presentation Layer**: UI components and state management.
- **Domain Layer**: Business logic and use cases.
- **Data Layer**: Repository pattern for data handling.

## Testing
- **Run unit tests**:
   ```sh
   flutter test

## Contribution
Contributions are welcome! 

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


## Contact
For any queries, please contact alexeybismus@gmail.com.
