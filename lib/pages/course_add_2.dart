import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';

class CourseAdd2 extends StatefulWidget {
  const CourseAdd2({
    super.key,
    required this.subjectCode,
  });
  //data required to show
  final String subjectCode;
  @override
  State<CourseAdd2> createState() => _CourseAdd2State();
}

class _CourseAdd2State extends State<CourseAdd2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
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
                  const Text('Course added sucessfully'),
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
                  Navigator.pop(context);
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
