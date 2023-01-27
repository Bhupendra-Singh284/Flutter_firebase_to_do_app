import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';
import 'package:provider/provider.dart';

class Mycheckbox extends StatefulWidget {
  const Mycheckbox({super.key, required this.index});

  final int index;

  @override
  State<Mycheckbox> createState() => _MycheckboxState();
}

class _MycheckboxState extends State<Mycheckbox> {
  bool pressed = false;
  @override
  void initState() {
    pressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoItemProvider = Provider.of<ToDoItem>(context);
    return Material(
      color: Colors.transparent,
      child: pressed
          ? IconButton(
              iconSize: 28,
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
              },
              icon: const Icon(Icons.check_box_outlined))
          : IconButton(
              iconSize: 28,
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
                Timer(const Duration(milliseconds: 130), (() {
                  pressed = false;
                  todoItemProvider.deleteTask(true, widget.index);
                }));
              },
              icon: const Icon((Icons.check_box_outline_blank))),
    );
  }
}
