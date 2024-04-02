import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/components/log_card.dart';

class LogsHome extends StatefulWidget {
  const LogsHome({super.key});

  @override
  State<LogsHome> createState() => _LogsHomeState();
}

class _LogsHomeState extends State<LogsHome> {
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
              hintText: 'Search logs',
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
                child: LogCard(
              searchKeyword: searchKeyword.text,
            )),
          ],
        ),
      ),
    );
  }
}
