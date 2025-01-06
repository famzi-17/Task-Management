# taskapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Task Management System
Project Description: The Task Management System is an application designed to streamline and manage tasks efficiently. This system is developed using Flutter for the mobile app interface, PHP for server-side logic, and MySQL as the database to store task data. The application allows users to create, update, and manage their tasks, as well as track progress.

Key Features:

User Authentication & Security: The system includes secure user authentication using passwords and encrypted communications.
Task Management: Users can create, update, delete, and view tasks. Each task includes details such as title, description, deadline, and status.
Email Notifications: The system has an email notification feature for reminders, task updates, and account activities. PHP Mailer is used for sending emails securely.
Responsive Design: Developed using Flutter, the app works seamlessly on both Android and iOS devices.
Task Priority & Status: Users can assign priority levels to tasks and mark them as completed, in-progress, or pending.
Real-Time Updates: The system supports real-time task updates, ensuring that users always see the latest task status.
Technologies Used:

Flutter (for mobile app development)
PHP (server-side backend logic)
MySQL (database for storing tasks and user data)
PHP Mailer (for sending secure emails)
XAMPP (local development environment for running PHP and MySQL)
Composer (for managing PHP packages)
Security: Utilizes best practices for password hashing, secure email sending, and other safety measures.
Installation & Setup:

Prerequisites:

You must have XAMPP installed on your local machine (to run PHP and MySQL).
You will also need to install Composer (for PHP package management) and PHP Mailer (for email functionalities).
Clone the repository:

Clone the project from the GitHub repository.
Setup the backend (PHP + MySQL):

Extract the PHP files to the XAMPP htdocs directory.
Create a MySQL database and import the provided database schema.
Install PHP packages:

Run composer install in the backend directory to install required packages (including PHP Mailer).
Set up the Flutter app:

Install Flutter SDK on your machine and open the Flutter project.
Run the app on an emulator or a real device.
Configure Email Settings:

Edit the email configuration files (PHP Mailer settings) to use a valid SMTP server.
Usage Instructions:

After setting up the system, run the Flutter mobile app and use the provided authentication details to log in.
Users can create and manage tasks through the app interface.
Notifications for task deadlines and updates will be sent via email.
Note:

Make sure that PHP Mailer and other required dependencies are installed via Composer.
Ensure that XAMPP is running and the MySQL database is configured correctly.
Contributing: Feel free to fork this project, submit issues, or create pull requests if you have suggestions or improvements!

License: This project is open source and available under the [Your License Type] License.
