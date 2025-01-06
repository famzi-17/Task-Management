import 'package:flutter/material.dart';
import 'dart:convert';
import 'taskview.dart';
import 'registeruser.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: TaskFlowScreen(
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class TaskFlowScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TaskFlowScreen({super.key, required this.onToggleTheme});

  @override
  State<TaskFlowScreen> createState() => _TaskFlowScreenState();
}

class _TaskFlowScreenState extends State<TaskFlowScreen> {
  int totalTasks = 0;
  int completedTasks = 0;
  int pendingTasks = 0;

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  // API URL
  //final String addTaskApiUrl = 'http://10.0.2.2/PHP/add_task.php';

  // Fetch data from the API
  Future<void> fetchTaskStatistics() async {
    const String apiUrl = 'http://10.0.2.2/PHP/get_all_tasks.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            totalTasks = int.parse(data['data']['total_tasks']);
            completedTasks = int.parse(data['data']['completed_tasks']);
            pendingTasks = int.parse(data['data']['pending_tasks']);
          });
        } else {
          print('API success=false: ${data['message']}');
        }
      } else {
        print('API error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  // Function to submit the task to the API


  @override
  void initState() {
    super.initState();
    fetchTaskStatistics(); // Fetch data when the widget is initialized
  }

  // Function to show the ing a tasmodal for addk


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.task_outlined, size: 35, color: Colors.blue),
        shadowColor: Colors.blue,
        elevation: 4,
        // toolbarHeight: 100,// weynee appbarka cabirkiisa
        title: const Text(
          'Task Management',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        leadingWidth: 20,
        actions: [
          IconButton(
            // iftiinka
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            // color: Colors.red,
          ),
          // SizedBox(width: 20,),
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Task Statistics',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                // color: Colors.yellow
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Tasks',
                          style: TextStyle(

                            fontSize: 20,
                            //color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$totalTasks',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //kala sakin
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Completed Tasks',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$completedTasks',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pending Tasks',
                                style: TextStyle(
                                  //color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$pendingTasks',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 24.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task,
              color: Colors.blue,
            ),
            label: 'Tasks View',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add,
              color: Colors.blue,
            ),
            label: 'Register User',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageTasks()),// task view la wace
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserRegistrationPage()),// user management aa la wace
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),//home page ka aa la wace
            );
          }
        },
      ),
      //backgroundColor: Colors.purple,
    );
  }
}