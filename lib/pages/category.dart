import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/shared/category.dart';

class CategoryPage extends StatefulWidget {
  final category;
  const CategoryPage({super.key, required this.category});
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Category category;
  String name = '';
  TextEditingController nameCon = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      category = widget.category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, category);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(
            title: Text("hi there"),
          ),
          body: category.id == 0 ? addCategoryWidget() : null,
        ));
  }

  Widget addCategoryWidget() {
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
        TextButton(
          onPressed: () {
            Category category =
                Category(name: name.toString(), id: categories.length + 1);
            categories.add(category);
            Navigator.pop(context, "add task");
          },
          child: const Text("Add Task"),
        ),
      ],
    );
  }
}
