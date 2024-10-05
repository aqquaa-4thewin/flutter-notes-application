import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/shared/task.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({super.key, required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late Task task;

  DateTime deadLine = DateTime.now();

  String desc = '';
  String name = '';
  TextEditingController deadLineCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  bool isEditPage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      task = widget.task;
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*  PopScope(
      canPop: true,
      onPopInvoked: (value) async {
        print(value);
        if (value) Navigator.pop(context, task);
      }, */
        WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, task);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(task.id == 0
              ? "Add Task Page"
              : isEditPage
                  ? "Edit Task Page"
                  : "Task Details Page"),
          centerTitle: true,
          actions: [
            if (task.id != 0)
              !isEditPage
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isEditPage = !isEditPage;
                          deadLineCon.text = formattedDate(task.deadline);
                          nameCon.text = task.name;
                          descCon.text = task.description;
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isEditPage = !isEditPage;
                          task = Task(
                              name: nameCon.text.toString(),
                              id: task.id,
                              description: descCon.text.toString(),
                              deadline: deadLine,
                              createdDate: task.createdDate,
                              categoryId: task.categoryId,
                              isChecked: task.isChecked);
                        });
                      },
                      icon: const Icon(
                        Icons.save,
                      ),
                    ),
          ],
        ),
        body: task.id != 0 ? taskDetailsWidget() : addTaskWidget(),
      ),
    );
  }

  Widget taskDetailsWidget() {
    return isEditPage
        ? addTaskWidget()
        : ListView(
            children: [
              ListTile(
                title: const Text("Name"),
                subtitle: Text(task.name),
              ),
              ListTile(
                title: const Text("Description"),
                subtitle: Text(task.description),
              ),
              ListTile(
                title: const Text("Creted Date"),
                subtitle: Text(formattedDate(task.createdDate)),
              ),
              ListTile(
                title: const Text("DeadLine Date"),
                subtitle: Text(formattedDate(task.deadline)),
              ),
            ],
          );
  }

  Widget addTaskWidget() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: nameCon,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
              hintText: "Enter Task Name",
            ),
            onChanged: (value) {
              name = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: descCon,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Description",
              hintText: "Enter Task Description",
            ),
            onChanged: (value) {
              desc = value;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            readOnly: true,
            controller: deadLineCon,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Dead Line",
              hintText: "Enter Task Dead Line",
            ),
            onTap: () {
              selectDate();
            },
          ),
        ),
        if (!isEditPage)
          TextButton(
            onPressed: () {
              task = Task(
                categoryId: 1,
                createdDate: DateTime.now(),
                deadline: deadLine,
                description: desc,
                name: name,
                id: tasks.length + 1,
                isChecked: false,
              );
              tasks.add(task);
              Navigator.pop(context, "add task");
            },
            child: const Text("Add Task"),
          ),
      ],
    );
  }

  Future<void> selectDate() async {
    await showDatePicker(
      context: context,
      initialDate: deadLine,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((onValue) {
      if (onValue != null) {
        setState(() {
          deadLine = DateTime(
            onValue.year,
            onValue.month,
            onValue.day,
            deadLine.hour,
            deadLine.minute,
          );

          selectTime();
        });
      }
    });
  }

  Future<void> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(deadLine),
    );
    if (picked != null) {
      setState(() {
        deadLine = DateTime(
          deadLine.year,
          deadLine.month,
          deadLine.day,
          picked.hour,
          picked.minute,
        );

        deadLineCon.text = formattedDate(deadLine).toString();
      });
    }
  }
}
