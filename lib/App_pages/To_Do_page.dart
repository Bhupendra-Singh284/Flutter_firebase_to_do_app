import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/App_pages/App_pages_reusable_widgets.dart';
import 'package:flutter_to_do_app/reusable_widgets/form_elements.dart';

class ToDoPage extends StatelessWidget {
  ToDoPage({super.key});
  var names = ["Ajay", "Aman", "Anirudh", "Aditya", "Bijendra", "Hemant"];
  var surnames = ["Tawar", "Sharma", "Verma", "Chouhan", "Kumar", "Pandey"];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.only(bottom: 60)),
            Center(child: AppPageElements.createSearchbar()),
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            const Text(
              "All Too Do's",
              style: TextStyle(
                  color: Color.fromARGB(255, 179, 174, 174),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ]),
          ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 30);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: names.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 60,
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.5,
                            color: const Color.fromARGB(255, 152, 150, 150)
                                .withOpacity(0.7),
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      leading: const Icon(
                        Icons.check_box,
                        color: Colors.white,
                      ),
                      subtitle: Formelements.createCustomText(surnames[index],
                          15, const Color.fromARGB(255, 213, 208, 208), false),
                      title: Formelements.createCustomText(
                          names[index], 30, Colors.white, true)),
                );
              }),
        ]));
  }
}
