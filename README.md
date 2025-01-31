# notes_app

A Flutter application for note taking with Firebase.

## Features
- User authentication with email and password.
- Securely store notes using Firebase Firestore.
- CRUD operations for notes.
- Toggle between light and dark mode.  

## Firebase Setup
- Firebase Authentication: Email/Password authentication is enabled, allowing users to sign up, sign in, reset passwords, and verify email addresses.
- Firestore Database: Used to store user notes securely.

### Firestore Security Rules
```plaintext
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow only authenticated users to read/write their own notes
    match /notes/{noteId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Getting Started
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
