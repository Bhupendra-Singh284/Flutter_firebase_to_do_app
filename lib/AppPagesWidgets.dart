import 'package:flutter/material.dart';

class AppPageWidgets {
  static AlertDialog createNewTask() {
    return AlertDialog(
      title: const Text(
        "Add new task",
        style: TextStyle(
            fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 28),
      ),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        SizedBox(
          height: 40,
          child: ElevatedButton(
              style: const ButtonStyle(elevation: MaterialStatePropertyAll(3)),
              onPressed: () {},
              child: const Text(
                "Add",
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
              )),
        )
      ],
      content: SizedBox(
        width: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(
              "Title",
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w200),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            TextField(
              maxLines: 3,
              maxLength: 60,
              minLines: 1,
              style: TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  contentPadding: EdgeInsets.only(bottom: 10)),
            ),
            Padding(padding: EdgeInsets.only(bottom: 16)),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            TextField(
              maxLength: 200,
              minLines: 1,
              maxLines: 10,
              style: TextStyle(fontSize: 18, height: 1.5),
              decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  contentPadding: EdgeInsets.only(bottom: 10)),
            )
          ],
        ),
      ),
    );
  }
}
