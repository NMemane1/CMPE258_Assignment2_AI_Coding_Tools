import 'package:flutter/material.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Tasks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController controller = TextEditingController();

  void addTask() {
    if (controller.text.isEmpty) return;

    setState(() {
      tasks.add({
        "title": controller.text,
        "done": false
      });
      controller.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["done"] = !tasks[index]["done"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Task Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text("Add"),
                )
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[index]["done"],
                      onChanged: (_) => toggleTask(index),
                    ),
                    title: Text(
                      tasks[index]["title"],
                      style: TextStyle(
                        decoration: tasks[index]["done"]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteTask(index),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
