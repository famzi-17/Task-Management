import 'package:flutter/material.dart';
// import 'package:taskapp/HomePage.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(), // Directly use the WelcomePage as the main screen
      routes: {
        '/login': (context) => LoginPage(), // Login Page route
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //shaashada dhan colorkeeda
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// Header Image
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.pexels.com/photos/110473/pexels-photo-110473.jpeg?auto=compress&cs=tinysrgb&w=600'), // Image in assets folder
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

// containerka waa dhamaaye

                Positioned(
                  bottom: 20,
                  left: 07,
                  child: Text(
                    'Welcome to Task Management App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // qoraalka waa dhamaaye
              ],
            ),

            SizedBox(height: 20),

// Section Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'What We Offer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
//title ka waa dhamaaye
            SizedBox(height: 10),

// Features Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  buildFeatureContainer(
                    title: 'Manage Your Tasks',
                    description:
                        'Easily create, assign, and track tasks in one place.',
                    icon: Icons.task,
                    color: Colors.blue.shade100,
                  ),
                  buildFeatureContainer(
                    title: 'Collaborate with Teams',
                    description:
                        'Assign tasks to team members and improve productivity.',
                    icon: Icons.group,
                    color: Colors.green.shade100,
                  ),
                  buildFeatureContainer(
                    title: 'Stay Notified',
                    description:
                        'Receive real-time notifications about task updates.',
                    icon: Icons.notifications,
                    color: Colors.pink.shade100,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

// Get Started Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/login'); // Navigate to Login Page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

// Reusable Widget for Feature Containers
  Widget buildFeatureContainer({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.black54),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
