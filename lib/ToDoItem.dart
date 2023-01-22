import 'package:flutter/material.dart';

class ToDoItem extends ChangeNotifier {
  static final title = [];
  static final description = [];

  bool isListEmpty() {
    return title.isEmpty;
  }

  int sizeofList() {
    return title.length;
  }

  void addNewTask(String inputTitle, String inputDescription) {
    title.add(inputTitle);
    description.add(inputDescription);
    notifyListeners();
  }

  void deleteTask(String inputTitle, String inputDescription) {
    title.remove(inputTitle);
    description.remove(inputDescription);
    notifyListeners();
  }

  Padding createList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sizeofList(),
          itemBuilder: (context, index) {
            return createTile(title[index], description[index]);
          }),
    );
  }

  Container createTile(String title, String description) {
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
        horizontalTitleGap: 8,
        dense: true,
        isThreeLine: false,
        contentPadding: const EdgeInsets.all(7),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              color: const Color.fromARGB(255, 196, 194, 194).withOpacity(0.7),
            ),
            borderRadius: BorderRadius.circular(20)),
        trailing: SizedBox(
          width: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                isSelected: true,
                iconSize: 26,
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.edit_note_rounded),
                color: Colors.blue.withOpacity(0.9),
                onPressed: () {
                  print("tapped edit button");
                },
              ),
              const Padding(padding: EdgeInsets.only(right: 5)),
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(right: 8),
                iconSize: 26,
                icon: const Icon(Icons.delete_rounded),
                color: const Color.fromARGB(253, 41, 152, 249).withOpacity(0.9),
                onPressed: () {
                  deleteTask(title, description);
                  print("tapped delete button");
                },
              )
            ],
          ),
        ),
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.check_box_outline_blank),
          onPressed: () {},
        ),
        subtitle: Text(
          description.length > 50
              ? "${description.substring(0, 50)}..."
              : description,
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
