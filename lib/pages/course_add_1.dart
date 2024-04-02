import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_dropdown_menu.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/components/custom_text_form_field.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/controller/course_controller.dart';
import 'package:student_management_system/pages/course_add_2.dart';

class CourseAdd1 extends StatefulWidget {
  const CourseAdd1({super.key});

  @override
  State<CourseAdd1> createState() => _CourseAdd1State();
}

class _CourseAdd1State extends State<CourseAdd1> {
  //controller data
  final TextEditingController _semester = CourseControllerData().semester;
  final TextEditingController _subjectCode = CourseControllerData().subjectCode;
  final TextEditingController _subjectName = CourseControllerData().subjectName;
  final TextEditingController _shortName = CourseControllerData().shortName;
  final TextEditingController _isGPA = CourseControllerData().isGPA;
  final TextEditingController _credits = CourseControllerData().credits;
  final TextEditingController _isCompulsory =
      CourseControllerData().isCompulsory;
  final TextEditingController _lecturerName =
      CourseControllerData().lecturerName;

  //to show loading icon
  bool isLoading = false;

  //subject code
  String subCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: GlowingOverscrollIndicator(
        color: Theme.of(context).colorScheme.primaryContainer,
        axisDirection: AxisDirection.down,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                //semester
                CustomDropdownMenu(
                  hint: 'Semseter',
                  entryList: semesters,
                  controller: _semester,
                ),
                const FormGap(),
                //subjet code
                CustomTextFormFiled(
                  hint: 'Subject Code',
                  controller: _subjectCode,
                ),
                const FormGap(),
                //subjet name
                CustomTextFormFiled(
                  hint: 'Subject Name',
                  controller: _subjectName,
                ),
                const FormGap(),
                //short name
                CustomTextFormFiled(
                  hint: 'Short Name',
                  controller: _shortName,
                ),
                const FormGap(),
                //isGPA
                CustomDropdownMenu(
                  controller: _isGPA,
                  hint: "GPA/NGPA",
                  entryList: isGPA,
                ),
                const FormGap(),
                //nic
                CustomTextFormFiled(
                  hint: 'Number of Credits',
                  controller: _credits,
                ),
                const FormGap(),
                //isCompulsory
                CustomDropdownMenu(
                  controller: _isCompulsory,
                  hint: "Compulsory/Elective",
                  entryList: isCompulsory,
                ),
                const FormGap(),
                CustomTextFormFiled(
                  hint: 'Lecturer Name',
                  controller: _lecturerName,
                ),
                const FormGap(),
                //next button
                CustomFilledButton(
                  onPressed: addNewCourse,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //************ methods

  void goToNextPage(String subjectCode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseAdd2(
          subjectCode: subjectCode,
        ),
      ),
    );
  }

  //snackbar
  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  //clear all text fields and reset selected menus
  void clearAllFields() {
    setState(() {
      _semester.clear();
      _subjectCode.clear();
      _subjectName.clear();
      _shortName.clear();
      _isGPA.clear();
      _credits.clear();
      _isCompulsory.clear();
      _lecturerName.clear();
    });
  }

  //add to firebase
  void addNewCourse() async {
    setState(() {
      isLoading = true;
      subCode = _subjectCode.text;
    });

    try {
      await FirebaseFirestore.instance
          .collection('Course')
          .doc(_subjectCode.text)
          .set({
        'semester': _semester.text,
        'subjectCode': _subjectCode.text,
        'subjectName': _subjectName.text,
        'shortName': _shortName.text,
        'isGPA': _isGPA.text,
        'credits': _credits.text,
        'isCompulsory': _isCompulsory.text,
        'lecturerName': _lecturerName.text,
      });

      //clear fields
      clearAllFields();
      //navigate to next page
      goToNextPage(subCode);
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
