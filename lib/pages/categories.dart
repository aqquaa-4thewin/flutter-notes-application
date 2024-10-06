import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/category.dart';
import 'package:flutter_application_2/pages/category.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:flutter_application_2/widgets/custom-bnb.dart';
import 'package:flutter_application_2/shared/category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Categotries List"),
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return categoryCard(categories[index]);
          },
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  Category newCategory = Category(name: "", id: 0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CategoryPage(
                        category: newCategory,
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
            ),
          ),
        ),
      ]),
      bottomNavigationBar: customBNB(),
    );
  }

  Widget categoryCard(category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CategoryPage(
              category: category,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(15),
        color: Colors.amber,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListTile(
            title: Text(
              category.name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
