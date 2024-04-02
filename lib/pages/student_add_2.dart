import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/pages/student_register_course.dart';

class StudentAdd2 extends StatefulWidget {
  const StudentAdd2({
    super.key,
    required this.email,
    required this.indexNumber,
    required this.degree,
    required this.intake,
    required this.regnoDocID,
  });
  //data required to show
  final String email;
  final String indexNumber;
  //data need to pass to register courses
  final String intake;
  final String degree;
  final String regnoDocID;

  @override
  State<StudentAdd2> createState() => _StudentAdd2State();
}

class _StudentAdd2State extends State<StudentAdd2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
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
                  const Text('Student added sucessfully'),
                  const FormGap(),
                  const FormGap(),
                  Text(
                    'Registration Number: ',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const FormGap(),
                  Text(
                    widget.indexNumber,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const FormGap(),
                  const FormGap(),
                  Text(
                    'KDU E-mail: ',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const FormGap(),
                  Text(
                    widget.email,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              //next button
              CustomFilledButton(
                onPressed: goToNextPage,
                child: const Text('Register Courses'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentRegisterCourse(
          intake: widget.intake,
          degree: widget.degree,
          regnoDocID: widget.regnoDocID,
          regno: widget.indexNumber,
        ),
      ),
    );
  }
}
