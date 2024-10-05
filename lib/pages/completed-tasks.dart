import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_application_2/pages/task.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:flutter_application_2/shared/task.dart';
import 'package:flutter_application_2/widgets/custom-bnb.dart';
import 'package:flutter_application_2/controllers/task.dart' as taskController;
import 'package:flutter_application_2/widgets/custom-dialog.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: taskStreamController.stream,
          builder: (context, snapshot) {
            print(snapshot.data);
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Search",
                        hintText: "Enter Task Name",
                      ),
                      onChanged: (value) {
                        taskController.search(value, true);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: finishedTasks.isEmpty
                      ? const Center(
                          child: Text("No Tasks Found!"),
                        )
                      : ListView.builder(
                          itemCount: filterdTasks.isNotEmpty
                              ? filterdTasks.length
                              : finishedTasks.length,
                          itemBuilder: (context, index) {
                            return taskCard(
                              filterdTasks.isNotEmpty
                                  ? filterdTasks[index]
                                  : finishedTasks[index],
                            );
                          },
                        ),
                ),
              ],
            );
          }),
      bottomNavigationBar: customBNB(),
    );
  }

  Widget taskCard(Task task) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TaskPage(
              task: task,
            ),
          ),
        ).then((newTask) {
          print(newTask);
          taskController.updateTaskData(task, newTask);
        });
      },
      child: Card(
        color: const Color.fromARGB(255, 117, 160, 234),
        margin: const EdgeInsets.all(16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 26, 25, 35)),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    "Created: ${formattedDate(task.createdDate)}",
                    style: const TextStyle(
                        fontSize: 14.0, color: Color.fromARGB(255, 26, 25, 25)),
                  ),
                  const Spacer(),
                  Text(
                    "Deadline: ${formattedDate(task.deadline)}",
                    style: const TextStyle(
                        fontSize: 14.0, color: Color.fromARGB(255, 26, 25, 35)),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                task.description,
                style: const TextStyle(fontSize: 14.0),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: task.isChecked,
                    onChanged: (value) {
                      setState(() {
                        task.isChecked = value!;
                        if (!value) {
                          taskController.deleteTask(task);
                          tasks.add(task);
                        }
                      });
                    },
                    activeColor: const Color(0xFF6898EE),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => customDialog(task, (task) {
                          // Here, you can call taskController.deleteTask or any other action
                          taskController.deleteTask(task);
                        }),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
