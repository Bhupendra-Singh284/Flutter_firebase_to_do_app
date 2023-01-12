import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/App_pages_reusable_widgets.dart';

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
        const Padding(padding: EdgeInsets.only(bottom: 35)),
        Center(child: AppPageElements.createSearchbar()),
        const Padding(padding: EdgeInsets.only(bottom: 30)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            " All To Do's",
            style: TextStyle(
                fontFamily: 'Lato_bold',
                color: Color.fromARGB(255, 80, 78, 78),
                fontSize: 32,
                fontWeight: FontWeight.w400),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 14)),
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
                        color: const Color.fromARGB(255, 196, 194, 194)
                            .withOpacity(0.7),
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
                          color: const Color.fromARGB(253, 41, 152, 249)
                              .withOpacity(0.9),
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
                    description[index],
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      color: Color.fromARGB(255, 178, 174, 174),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  title: Text(
                    title[index],
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 60, 59, 59),
                        fontFamily: 'Lato_bold',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }),
      ),
      const Padding(padding: EdgeInsets.only(bottom: 14))
    ]);
  }
}
