# SwiftUI Firebase Authentication (MVVM)

A production-style iOS authentication module built with **SwiftUI**, **Firebase Authentication**, and **MVVM architecture**.

This project demonstrates a clean and scalable authentication flow for modern iOS applications, including user registration, login, session persistence, and logout functionality. It emphasizes maintainable architecture, separation of concerns, and reusable components suitable for enterprise-scale mobile applications.

---

## Features

- Email & Password Sign Up
- User Login
- Session Persistence
- User Logout
- Form Validation
- Error Handling & User Feedback
- Reactive UI Updates with SwiftUI
- Modular MVVM Architecture
- Firebase Authentication Integration

---

## Architecture

This project follows the **Model-View-ViewModel (MVVM)** architecture.

### Layers

### View
Responsible for rendering UI and forwarding user interactions to the ViewModel.

**Examples:**
- EmailAndPasswordView
- LoginView
- ProfileView
- SignInWithAppleView
- SignInWithGoogleView
- SignUpView

### ViewModel
Contains presentation logic, state management, validation, and business rules.

**Responsibilities:**
- Manage authentication state
- Validate input
- Handle loading/error states
- Communicate with services

**Examples:**
- EmailAndPasswordViewModel
- LoginViewModel
- ProfileViewModel
- SignUpViewModel

### Model
Represents domain and application data.

**Examples:**
- User
- AuthState

### Service Layer
Handles communication with external systems such as Firebase.

**Examples:**
- AuthService
- FirebaseManager

---

## Tech Stack

- Swift 5+
- SwiftUI
- MVVM
- Firebase Authentication
- Combine / ObservableObject
- Xcode
- Git

---

## Project Structure

```text
swiftui-firebase-auth-mvvm/
├── Models/
├── Views/
│   ├── Authentication/
│   ├── Components/
│   └── Profile/
├── ViewModels/
├── Services/
├── Utilities/
└── Resources/
```
---

## Authentication Flow

1. User launches the app  
2. Firebase session is checked  
3. If authenticated → Navigate to Home/Profile  
4. If unauthenticated → Show Login/Register screen  
5. User logs in or signs up  
6. Authentication state updates UI automatically  

---

## Firebase Setup

### Prerequisites

- Xcode 15+
- CocoaPods or Swift Package Manager
- Firebase project from Google Firebase Console
  
Create a Firebase project here:

Firebase Console: https://console.firebase.google.com/

Enable:

- Authentication
- Email/Password Sign-In Method

Add the `GoogleService-Info.plist` file to the project root.

---

## Installation

Clone repository:

```bash
git clone https://github.com/jalalhemidach/swiftui-firebase-auth-mvvm.git
```

Open project:

```bash
open swiftui-firebase-auth-mvvm.xcodeproj
```

Install dependencies and run.

---

## Engineering Principles Applied

- Single Responsibility Principle
- Separation of Concerns
- Dependency Abstraction
- Scalable Folder Organization
- Testable Architecture
- Reusable SwiftUI Components

---

## Future Improvements

- Password Reset
- Email Verification
- Biometric Authentication (Face ID / Touch ID)
- OAuth Login (Google / Apple)
- Unit Testing
- Snapshot Testing
- CI/CD Pipeline

---

## Technical Concepts Demonstrated

- SwiftUI state management
- Firebase integration
- Authentication workflows
- Production-ready MVVM architecture
- Scalable mobile engineering practices

---

## Author

**Jalal Hemidach**  
Senior iOS Engineer | Swift | SwiftUI | Mobile Architecture
