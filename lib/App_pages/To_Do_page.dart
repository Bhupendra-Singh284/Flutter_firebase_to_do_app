import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/App_pages_reusable_widgets.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';
import 'package:provider/provider.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoItemProvider = Provider.of<ToDoItem>(context);

    return ListView(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.only(bottom: 25)),
        Center(child: AppPageElements.createSearchbar()),
        const Padding(padding: EdgeInsets.only(bottom: 30)),
      ]),
      Consumer<ToDoItem>(
        builder: (context, value, child) => Container(
          child: todoItemProvider.isListEmpty()
              ? Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Tap the + icon to add tasks",
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 28,
                          color: const Color.fromARGB(255, 171, 165, 165)
                              .withOpacity(0.7)),
                    ),
                  ),
                )
              : todoItemProvider.createList(),
        ),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 14))
    ]);
  }
}
