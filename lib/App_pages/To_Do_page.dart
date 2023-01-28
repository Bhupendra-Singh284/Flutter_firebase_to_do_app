import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';
import 'package:provider/provider.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoItemProvider = Provider.of<ToDoItem>(context);

    return ListView(children: [
      const Padding(padding: EdgeInsets.only(bottom: 25)),
      Consumer<ToDoItem>(
        builder: (context, value, child) => Container(
          child: todoItemProvider.isListEmpty()
              ? todoItemProvider.tododataChecked()
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
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "loading data , please wait",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 28,
                              color: const Color.fromARGB(255, 171, 165, 165)
                                  .withOpacity(0.7)),
                        ),
                      ),
                    )
              : todoItemProvider.createList(false, context),
        ),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 75))
    ]);
  }
}
