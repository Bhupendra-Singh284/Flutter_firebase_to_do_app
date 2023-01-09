import 'package:flutter/material.dart';

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
          TextField(
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 139, 139)),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search tasks",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(25))),
          ),
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
