import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/add_task_provider.dart';
import '../Services/auth_provider.dart';
import '../UI/add_tasks.dart';
import '../UI/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTasks()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(

        actions: [
          InkWell(
            onTap: () {
              AuthProvider().signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Icon(Icons.logout),
          ),
        ],
        title: Text("Tasks"),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<AddTaskProvider>(builder: (context, value, index) {
        final tasks = value.Tasks;
        if (tasks.isEmpty) {
          return Center(
            child: Text(
              "No tasks available yet!",
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['description']),
                  trailing: Checkbox(
                    value: task['isCompleted'],
                    onChanged: (value) {
                      AddTaskProvider().updatedTask(task['id'], {
                        "title": task['title'],
                        "description": task['description'],
                        "isCompleted": value ?? false,
                      });
                    },
                  ),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Task Option"),
                        content: Text("Choose the suitable option"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the first dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final titleController =
                                  TextEditingController(text: task['title']);
                                  final descriptionController =
                                  TextEditingController(text: task['description']);
                                  return AlertDialog(
                                    title: Text("Update Task"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            labelText: "Title",
                                          ),
                                        ),
                                        TextField(
                                          controller: descriptionController,
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close update dialog
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AddTaskProvider().updatedTask(task['id'], {
                                            "title": titleController.text,
                                            "description": descriptionController.text,
                                            "isCompleted": task['isCompleted'],
                                          });
                                          Navigator.of(context).pop(); // Close update dialog
                                        },
                                        child: Text("Update"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Update"),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<AddTaskProvider>(context, listen: false).deleteTask(task['id']);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  ),
                );
              });
        }
      }),
    );
  }
}
