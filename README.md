# JVec Assessment Frontend - Contact Book App

Welcome to the JVec Assessment Frontend Contact Book Flutter project. This README will guide you through the installation and usage of the Contact Book App built using Flutter. The Contact Book App allows you to manage your contacts easily. 

## Prerequisites

Before getting started with the Contact Book App, make sure you have the following prerequisites in place:

1. **Flutter:** Ensure you have Flutter installed on your system. If you haven't already, you can follow the installation guide at [Flutter's official website](https://flutter.dev/docs/get-started/install).

2. **Flutter IDE (Optional):** You can use Android Studio, Visual Studio Code, or any other IDE of your choice to develop Flutter applications. Install the Flutter and Dart plugins for your chosen IDE.

3. **Contact Book App Backend:** Ensure that you have the Contact Book App Backend running. Refer to the backend's README for installation and usage instructions.

4. **Mobile Device or Emulator:** To run the app, you need a physical mobile device or a mobile emulator.

## Installation

Follow these steps to install and run the Contact Book App:

1. Clone the repository:

   ```bash
   git clone https://github.com/KiCodes/jvec-assessment-frontend.git
   ```

2. Navigate to the project directory:

   ```bash
   cd jvec-assessment-frontend
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Open the `lib/daTA/remore_datasource.dart` file and update the `baseUrl` to match the URL of your Contact Book App Backend:

   ```dart
   final String baseUrl = 'http://localhost.com';
   ```

## Usage

To run the Contact Book App, follow these steps:

1. Connect your mobile device to your computer or start an emulator.

2. Open a terminal and navigate to your project directory.

3. Run the app:

   ```bash
   flutter run
   ```

   This command will build and install the app on your connected device or emulator.

4. Once the app is installed, you can open it on your device. You'll be presented with the login screen.

5. Use the user registration and login endpoints provided by the backend to create a user account or log in with an existing account.

6. After logging in, you'll have access to the Contact Book features. You can add, update, delete

7. Explore the app's functionalities and enjoy managing your contacts seamlessly.

## Important Notes

- The Contact Book App is connected to the Contact Book App Backend, so ensure the backend is running and accessible from your device.

- If you encounter any issues or have questions about the app, feel free to reach out for assistance or refer to the code comments.

Now you're ready to start using the Contact Book App! Enjoy managing your contacts and exploring the features it offers.
