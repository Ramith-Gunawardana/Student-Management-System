import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_management_system/components/course_card.dart';
import 'package:student_management_system/components/custom_sized_box.dart';

class CoursesHome extends StatefulWidget {
  const CoursesHome({super.key});

  @override
  State<CoursesHome> createState() => _CoursesHomeState();
}

class _CoursesHomeState extends State<CoursesHome> {
  //contoller
  TextEditingController searchKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          top: 6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const FormGap(),
            //search bar
            SearchBar(
              hintText: 'Search courses',
              controller: searchKeyword,
              onChanged: (value) {
                setState(() {
                  searchKeyword.text = value;
                });
              },
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ),
            ),
            const FormGap(),
            //course cards
            Expanded(
                child: CourseCard(
              searchKeyword: searchKeyword.text,
            )),
          ],
        ),
      ),
    );
  }
}
