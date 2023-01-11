import 'package:flutter/material.dart';

class AppPageElements {
  static Container createSearchbar() {
    return Container(
      width: 329,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(55),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                color: Color.fromARGB(255, 182, 180, 180),
                blurRadius: 3.5)
          ]),
      child: SizedBox(
        width: 327,
        child: TextField(
          style: const TextStyle(fontSize: 18),
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
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(
                      width: 0,
                      color: const Color.fromARGB(255, 192, 189, 189)
                          .withOpacity(0.5))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0,
                      color: const Color.fromARGB(255, 200, 197, 197)
                          .withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(50))),
        ),
      ),
    );
  }
}
