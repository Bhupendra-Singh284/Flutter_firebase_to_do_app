import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/App_pages_reusable_widgets.dart';
import 'package:flutter_to_do_app/ToDoItem.dart';

class ToDoPage extends StatelessWidget {
  ToDoPage({super.key});

  var title = [
    "Buy Groceries",
    "Complete Homework",
    "Calculte monthly bill",
    "Walk to park",
    "Complete online tutorial ",
    "Complete projects work",
    "Write a message to teacher",
    "Wash Clother"
  ];
  var description = [
    "buy chips, biscuits, fries, pasta, noodles, cookies, soda",
    "complete maths and physics homework ,Q1 to Q10 of chapter 3 in maths and Q5 to Q9 of chapter 6 in physics",
    "calculate monthly bill and reduce any unwanted spendings",
    "walk to nearby park with dog",
    "complete dsa series of love babbar lecture #15 currently",
    "complete chart drawing work in project of chemistry dos- 19/1/2023",
    "write message to teacher to change old furniture of class and bring more chairs",
    "wash clothes and socks"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.only(bottom: 25)),
        Center(child: AppPageElements.createSearchbar()),
        const Padding(padding: EdgeInsets.only(bottom: 30)),
      ]),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 30);
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: title.length,
            itemBuilder: (context, index) {
              return ToDoItem.createTile(title[index], description[index]);
            }),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 14))
    ]);
  }
}
