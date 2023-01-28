import 'package:flutter/material.dart';

class AppPageWidgets {
  static AlertDialog addOrEditTask(
      int index,
      final todoItemProvider,
      bool editTask,
      TextEditingController titleController,
      TextEditingController descriptionController,
      GlobalKey<FormState> formkey,
      BuildContext context) {
    if (!editTask) {
      titleController.clear();
      descriptionController.clear();
    }
    return AlertDialog(
      title: Text(
        editTask ? "Edit Task" : "Add new task",
        style: const TextStyle(
            fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 28),
      ),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(2)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
                )),
          ),
          const Padding(padding: EdgeInsets.only(right: 15)),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(2)),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (descriptionController.text.isEmpty) {
                      descriptionController.text = " ";
                    }
                    print("correct input");
                    editTask
                        ? todoItemProvider.editTaskBackend(
                            index,
                            titleController.text.toString(),
                            descriptionController.text.toString())
                        : todoItemProvider.addNewTask(
                            titleController.text.toString(),
                            descriptionController.text.toString(),
                            false);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  editTask ? "Save" : "Add",
                  style: const TextStyle(
                      fontSize: 18, color: Colors.white, fontFamily: 'Lato'),
                )),
          ),
          const Padding(padding: EdgeInsets.only(right: 10)),
        ])
      ],
      content: SizedBox(
        width: 150,
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              const Text(
                "Title",
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w200),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a title";
                  }
                  if (value.length > 80) {
                    return "Title should be between 0 to 80 letters";
                  }
                  return null;
                },
                controller: titleController,
                minLines: 1,
                maxLines: 1,
                style: const TextStyle(fontSize: 18, height: 1.5),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(fontSize: 14),
                    isDense: true,
                    counterText: "",
                    contentPadding: EdgeInsets.only(bottom: 10)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value!.length > 150) {
                    return "Description should be between 0 to 150 letters";
                  }
                  return null;
                },
                minLines: 1,
                maxLines: 3,
                style: const TextStyle(fontSize: 18, height: 1.5),
                decoration: const InputDecoration(
                    errorStyle: TextStyle(fontSize: 14),
                    counterText: "",
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 10)),
              )
            ],
          ),
        ),
      ),
    );
  }

  static AlertDialog editTask() {
    return AlertDialog(
      title: const Text(
        "Edit task",
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
                "Save",
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
