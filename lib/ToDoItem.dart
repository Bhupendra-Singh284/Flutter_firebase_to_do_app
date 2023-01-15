import 'package:flutter/material.dart';

class ToDoItem {
  static Container createTile(String title, String description) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 205, 200, 200),
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 0.1)
          ]),
      child: ListTile(
        dense: true,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(5),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color: const Color.fromARGB(255, 196, 194, 194).withOpacity(0.7),
            ),
            borderRadius: BorderRadius.circular(20)),
        trailing: SizedBox(
          width: 74,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                isSelected: true,
                iconSize: 25,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.edit_note_rounded),
                color: Colors.blue.withOpacity(0.9),
                onPressed: () {
                  print("tapped edit button");
                },
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 8),
                iconSize: 25,
                icon: const Icon(Icons.delete_rounded),
                color: const Color.fromARGB(253, 41, 152, 249).withOpacity(0.9),
                onPressed: () {
                  print("tapped delete button");
                },
              )
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.check_box_outline_blank),
          onPressed: () {},
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            color: Color.fromARGB(255, 178, 174, 174),
            fontWeight: FontWeight.w200,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 60, 59, 59),
              fontFamily: 'Lato_bold',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
