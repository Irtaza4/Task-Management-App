# Task-Management-App
Final internship project at DevelopersHub (remote). A Task Management App built with Flutter, Provider, and Firebase. The app allows users to create, update, delete, and manage tasks in real-time, with Firebase Authentication for sign-in and sign-out functionality.

Task Management App
A simple task management app built with Flutter, using Provider for state management and Firebase for backend services. Users can add, update, and delete tasks. The app provides a basic yet functional task tracking system.

Features
Task List: Displays a list of tasks fetched from Firebase Realtime Database.
Add Task: Allows users to add new tasks with a title and description.
Update Task: Users can update a task's details.
Delete Task: Users can delete tasks from the list.
Task Completion: Toggle task completion status using a checkbox.
Technologies Used
Flutter: For building the mobile app.
Provider: For state management.
Firebase Realtime Database: For storing and syncing task data.
Firebase Authentication: For user authentication and sign-out functionality.
Setup Instructions
Follow these steps to set up the project locally.

Prerequisites
Flutter: Make sure you have Flutter installed. If not, follow the installation guide on the official Flutter website: Flutter Installation.
Firebase Account: You’ll need a Firebase project. If you don’t have one, create one by visiting the Firebase Console: Firebase Console.
Clone the Repository

git clone https://github.com/Irtaza4/Task-Management-App.git
cd Task-Management-App
Install Dependencies
In the project directory, run:


flutter pub get
Set Up Firebase
Create a Firebase Project: If you haven't already, create a new Firebase project in the Firebase console.
Configure Firebase for Flutter:
Follow the Firebase Setup Documentation to configure Firebase for iOS and Android.
Add the google-services.json for Android or GoogleService-Info.plist for iOS to your project.
Enable Firebase Realtime Database: In the Firebase console, navigate to the "Realtime Database" section and create a new database.
Set Database Rules: For testing purposes, set the database rules to allow read and write operations:

{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null"
  }
}
Run the App
After setting up Firebase and ensuring all dependencies are installed, you can run the app with:


flutter run
Authentication Setup
The app includes basic Firebase Authentication with the ability to sign in and out. Ensure that you've enabled Email/Password Authentication in the Firebase console under "Authentication > Sign-in method."

Folder Structure

lib/
├── Services/
│   ├── add_task_provider.dart       # Provider for managing tasks
│   └── auth_provider.dart          # Provider for authentication
├── UI/
│   ├── add_tasks.dart              # Add new task UI
│   ├── home_screen.dart            # Home screen displaying tasks
│   └── login_screen.dart           # Login screen UI
└── main.dart                       # Main entry point of the app

