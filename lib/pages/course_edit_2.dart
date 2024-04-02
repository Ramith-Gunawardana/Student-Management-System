import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/pages/dashboard.dart';

class CourseEdit2 extends StatefulWidget {
  const CourseEdit2({
    super.key,
    required this.subjectCode,
  });
  //data required to show
  final String subjectCode;
  @override
  State<CourseEdit2> createState() => _CourseEdit2State();
}

class _CourseEdit2State extends State<CourseEdit2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.check_circle_outline_rounded),
                  const FormGap(),
                  const Text('Course updated sucessfully'),
                  const FormGap(),
                  const FormGap(),
                  Text(
                    'Subject Code: ',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const FormGap(),
                  Text(
                    widget.subjectCode,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              //next button
              CustomFilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(selectedIndex: 2),
                    ),
                  );
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
