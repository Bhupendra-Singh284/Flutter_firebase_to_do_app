import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/App_pages_reusable_widgets.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 60)),
          AppPageElements.createSearchbar(),
          const Padding(padding: EdgeInsets.only(bottom: 30)),
          const Text(
            "Completed Tasks",
            style: TextStyle(
                color: Color.fromARGB(255, 179, 174, 174),
                fontSize: 50,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
