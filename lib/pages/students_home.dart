import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/components/student_card.dart';

class StudentsHome extends StatefulWidget {
  const StudentsHome({super.key});

  @override
  State<StudentsHome> createState() => _StudentsHomeState();
}

class _StudentsHomeState extends State<StudentsHome> {
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
          children: [
            const FormGap(),
            //search bar
            SearchBar(
              hintText: 'Search students',
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
            //student card
            Expanded(
              child: StudentCard(
                searchKeyword: searchKeyword.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  String hint;
  List<DropdownMenuEntry<String>> entryList;
  double width;

  CustomDropDown({
    super.key,
    required this.hint,
    required this.entryList,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: hint,
      dropdownMenuEntries: entryList,
      width: width,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
