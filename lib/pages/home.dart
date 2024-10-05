import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_application_2/pages/task.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:flutter_application_2/shared/task.dart';
import 'package:flutter_application_2/widgets/custom-bnb.dart';
import 'package:flutter_application_2/controllers/task.dart' as taskController;
import 'package:flutter_application_2/widgets/custom-dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks App"),
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
                        taskController.search(value, false);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: tasks.isEmpty
                      ? const Center(
                          child: Text("No Tasks Found!"),
                        )
                      : ListView.builder(
                          itemCount: filterdTasks.isNotEmpty
                              ? filterdTasks.length
                              : tasks.length,
                          itemBuilder: (context, index) {
                            return taskCard(
                              filterdTasks.isNotEmpty
                                  ? filterdTasks[index]
                                  : tasks[index],
                            );
                          },
                        ),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Task emptyTask = Task(
            name: "",
            id: 0,
            description: "",
            deadline: DateTime.now(),
            createdDate: DateTime.now(),
            categoryId: 0,
            isChecked: false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TaskPage(
                task: emptyTask,
              ),
            ),
          ).then((onValue) {
            if (onValue == 'add task') {
              print("enter");
              taskStreamController.sink.add("event");
            }
          });
        },
        child: const Icon(Icons.add),
      ),
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
        color: const Color(0xFF90B4F2),
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

                        if (value) {
                          showDialog(
                            context: context,
                            builder: (context) => customDialog(task, (task) {
                              // Here, you can call taskController.deleteTask or any other action
                              taskController.finishedTask(task);
                            }),
                          );
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
                      // pass the reference of the function since it is a void function with no returned value
                      //taskController.deleteTask(task);
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

/*
Whatsapp Issue
  Widget taskCard(Task task) {
    return Card(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
            ),
            alignment: Alignment.centerLeft,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                          task.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: task.isChecked,
                          onChanged: (value) {
                            task.isChecked =
                                value!; // value = !tasks[index]['isChecked']
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(task.deadline
                          .toString()), //be carful to write the string correctly as in string => or you will get an error (you can avoid these errors by """models""")
                      SizedBox(width: 20),
                      Text(task.createdDate.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            /*       Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => TaskDetails(task: task))); */
                          },
                          icon: Icon(Icons.arrow_right))
                    ],
                  )
                ])));
  }
   */
}
