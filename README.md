# FlutterDoo

FlutterDoo is a Flutter mobile application that helps you manage your tasks efficiently. This app integrates Firebase authentication for user management and utilizes SQLite for local task storage. Users can create, update, delete, and mark tasks as completed.

## Features

### 1. User Authentication

- Firebase authentication for secure and reliable user management.
- Users can sign up, log in, and log out.

### 2. Task Management

- Create tasks with details such as title, description, due date, priority, and completion status.
- View a list of tasks, ordered by ID.
- Retrieve details of a specific task based on its ID.
- Update task details, including title, description, due date, priority, and completion status.
- Mark tasks as completed.
- Delete tasks.

### 3. Local Database

- SQLite is used for local storage of tasks.
- Automatic creation of database tables if not already existing.

### 4. Firebase Integration

- Firebase authentication is seamlessly integrated for a secure and user-friendly experience.
- Firebase can be extended for additional features, such as cloud storage and real-time updates.

## Getting Started

Follow these steps to set up and run the FlutterDoo app on your local machine.

1. Clone the repository:

    ```bash
    git clone https://github.com/anujbarve/FlutterDoo.git

2. Navigate to the project directory:
    ```bash
   cd Flutterdoo

3. Install Dependencies
   ```bash
   flutter pub get

4. Run the app
    ```bash
   flutter run