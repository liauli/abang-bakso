# AbangBakso

**Abang Bakso** is a mobile application that allows customers to track meatball vendors (Abang Tukang Bakso Keliling) in Indonesia. The app connects customers and sellers by showing nearby sellers on a map for customers, and nearby customers for sellers.

## Features

- **Customer Features:**
  - View nearby sellers on a map (within a set radius).
  - Track moving sellers in real-time.
  
- **Seller Features:**
  - View nearby customers looking for meatball orders.
  - Track own location and update in real-time.

## Installation

### Pre-requisites

Before starting with the installation, ensure you have the following tools installed on your machine:

1. **Xcodegen**: Used to generate the Xcode project from a `project.yml` file.
   - Install using Homebrew:
     ```bash
     brew install xcodegen
     ```

2. **CocoaPods**: A dependency manager for iOS projects.
   - Install using Homebrew:
     ```bash
     brew install cocoapods
     ```
   - Alternatively, if you're using macOS with a different package manager, you can install it via:
     ```bash
     sudo gem install cocoapods
     ```

3. **Fastlane**: Automates beta distribution, release management, and more for iOS apps.
   - Install using Homebrew:
     ```bash
     brew install fastlane
     ```
### Steps
To run the **Abang Bakso** app locally on your machine, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/liauli/abang-bakso.git
   ```

2. Open the project directory and run xcodegen. This will also executes `pod install`.
   ```
   xcodegen
   ```
3. **Set up Firebase**:
   - Go to the Firebase Console.
   - Create a new project and configure Firebase for iOS.
   - Download the GoogleService-Info.plist and add it to your Xcode project.
     
4. **Run the project**:
    - Open the generated .xcworkspace file with Xcode and build the project.
    - Connect a physical device or use a simulator to test the app.
  
## Contributing
We welcome contributions! If you'd like to help improve the Abang Bakso app, follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed description of the changes.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Future Features
1. Send notification to seller
   
