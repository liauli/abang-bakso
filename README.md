# AbangBakso

**Abang Bakso** is a mobile application that allows customers to track meatball vendors (Abang Tukang Bakso Keliling) in Indonesia. The app connects customers and sellers by showing nearby sellers on a map for customers, and nearby customers for sellers.

### Features

- **Customer Features:**
  - View nearby sellers on a map (within a set radius).
  - Track moving sellers in real-time.
  
- **Seller Features:**
  - View nearby customers looking for meatball orders.
  - Track own location and update in real-time.

### Installation

To run the **Abang Bakso** app locally on your machine, follow these steps:

1. **Install Xcodegen** (if not already installed):
   - Xcodegen is used for generating the Xcode project from a `project.yml` file. To install it, run the following command in the terminal:
   ```bash
   brew install xcodegen
   ```
     
2. **Clone the repository**:
   ```bash
   git clone https://github.com/liauli/abang-bakso.git
   ```

3. Open the project directory and run xcodegen. This will also executes `pod install`.
   ```
   xcodegen
   ```
4. **Set up Firebase**:
   - Go to the Firebase Console.
   - Create a new project and configure Firebase for iOS.
   - Download the GoogleService-Info.plist and add it to your Xcode project.
   - 
5. **Run the project**:
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
   
