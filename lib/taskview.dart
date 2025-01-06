import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManageTasks extends StatefulWidget {
  const ManageTasks({super.key});

  @override
  State<ManageTasks> createState() => _ManageTasksState();
}

class _ManageTasksState extends State<ManageTasks> {
  List tasks = [];
  List users = [];
  String? assignedToEmail;
  String? emailsend;
  String? desc;
  String status = 'pending'; // Default status is 'pending'

  @override
  void initState() {
    super.initState();
    fetchTasks();
    fetchUsers();
  }

  /// ✅ Fetch All Tasks
  Future<void> fetchTasks() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/tasks.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          tasks = data;
        });
      } else {
        showError('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error fetching tasks: $e');
    }
  }

  /// ✅ Fetch All Users
  Future<void> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/user.php'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          users = data;
        });
      } else {
        showError('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error fetching users: $e');
    }
  }

  /// ✅ Create Task
  Future<void> createTask(String title, String description, String duration) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/tasks.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": assignedToEmail,
          "title": title,
          "description": description,
          "duration": duration,
          "status": status, // Include the status here
        }),
      );

      if (response.statusCode == 200) {
        await fetchTasks();
        await sendEmail(); // 📨 Call SendGrid Email API
        Navigator.pop(context);
        showSuccess('Task created successfully!');
      } else {
        showError('Failed to create task: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error creating task: $e');
    }
  }

  /// ✅ Update Task
  Future<void> updateTask(int id, String title, String description, String duration) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/tasks.php?id=$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": assignedToEmail,
          "title": title,
          "description": description,
          "duration": duration,
          "status": status, // Include the status here
        }),
      );

      if (response.statusCode == 200) {
        await fetchTasks();
        await sendEmail(); // 📨 Call SendGrid Email API
        Navigator.pop(context);
        showSuccess('Task updated successfully!');
      } else {
        showError('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error updating task: $e');
    }
  }

  /// ✅ Delete Task
  Future<void> deleteTask(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/tasks.php?id=$id'),
      );

      if (response.statusCode == 200) {
        await fetchTasks();
        showSuccess('Task deleted successfully!');
      } else {
        showError('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error deleting task: $e');
    }
  }

  /// 📨 ✅ Send Email Notification
  Future<void> sendEmail() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/PHPMailer-6.9.3/PHPMailer/sendemail.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "recipient": emailsend,
          "message": "Hello, $desc "
        }),
      );

      if (response.statusCode == 200) {
        showSuccess('Email sent successfully!');
      } else {
        showError('Failed to send email: ${response.statusCode}');
      }
    } catch (e) {
      showError('Error sending email: $e');
    }
  }

  /// ✅ Show Add/Edit Task Form
  void _showTaskForm({Map? task}) {
    final TextEditingController titleController =
    TextEditingController(text: task?['title'] ?? '');
    final TextEditingController descriptionController =
    TextEditingController(text: task?['description'] ?? '');
    final TextEditingController durationController =
    TextEditingController(text: task?['duration'] ?? '');

    // Set status for the task form
    status = task?['status'] ?? 'pending'; // Default status is 'pending'

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task == null ? 'Create Task' : 'Edit Task'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  desc = value; // ✅ Capture Description
                },
              ),
              DropdownButton<String>(
                value: assignedToEmail,
                hint: const Text('Assign to'),
                onChanged: (String? newValue) {
                  setState(() {
                    assignedToEmail = newValue;
                    emailsend = users
                        .firstWhere((user) => user['id'].toString() == newValue)['email'];
                  });
                },
                items: users.map<DropdownMenuItem<String>>((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'].toString(),
                    child: Text(user['email']),
                  );
                }).toList(),
              ),
              // Status Dropdown
              DropdownButton<String>(
                value: status,
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'pending', child: Text('Pending',style: TextStyle(color: Colors.yellow),)),
                  DropdownMenuItem(value: 'complete', child: Text('Complete',style: TextStyle(color: Colors.green),)),
                ],
                hint: const Text('Select Status'),
              ),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (task == null) {
                createTask(titleController.text, descriptionController.text,
                    durationController.text);
              } else {
                updateTask(task['id'], titleController.text,
                    descriptionController.text, durationController.text);
              }
            },
            child: Text(task == null ? 'Create' : 'Update'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: tasks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            textColor: Colors.black87,
            title: Text(task['title'],style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            subtitle: Text(
                task['description'],style: TextStyle(fontSize: 15, ),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showTaskForm(task: task),
                ),
                IconButton(
                  color: Colors.red,
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteTask(task['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskForm(),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white // shaashada dhan color keeda
      ,
    );
  }
}
