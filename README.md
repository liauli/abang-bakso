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

### Minimum Requirements
- **iOS Version**: iOS 17.0 or later  
- **Xcode Version**: Xcode 15.0 or later (tested with Xcode 15.2)  
- **macOS Version**: macOS Ventura 13.4 or macOS Sonoma 14.1.2 or later  


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
        
4. **Run the project**:
    - Open the generated .xcworkspace file with Xcode and build the project.
    - Connect a physical device or use a simulator to test the app.
  
## Running Unit Test
This project includes unit tests to ensure code quality and functionality. You can run unit tests directly through **Xcode** or automate the process using **Fastlane**, managed with **Bundler**.

### 1. Running Tests with Xcode
1. Open the project in Xcode:
   ```
   open AbangBakso.xcworkspace
   ```
2. Select the appropriate scheme (e.g., `AbangBakso`).
3. Go to the top menu: **Product > Test** or press `Command + U`.
4. Xcode will execute the unit tests, and the results will appear in the Test Navigator.

---

### 2. Running Tests with Fastlane via Bundler

#### Install Bundler
1. Ensure you have Ruby installed:
   ```
   ruby --version
   ```
2. Install Bundler:
   ```
   gem install bundler
   ```

#### Install Fastlane with Bundler
1. Navigate to the project directory:
   ```
   cd <project-directory>
   ```
2. Install dependencies using Bundler:
   ```
   bundle install
   ```

#### Run Unit Tests with Fastlane
1. Execute the `test` lane using Bundler:
   ```
   bundle exec fastlane unit_test
   ```
  
## Contributing
We welcome contributions! If you'd like to help improve the Abang Bakso app, follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed description of the changes.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Future Features
1. Send notification to seller
   
