import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_dropdown_menu.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/components/custom_text_form_field.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/controller/course_controller.dart';
import 'package:student_management_system/pages/course_add_2.dart';
import 'package:student_management_system/pages/course_edit_2.dart';
import 'package:student_management_system/pages/dashboard.dart';

class CourseEdit1 extends StatefulWidget {
  const CourseEdit1({
    super.key,
    required this.docID,
  });
  final String docID;

  @override
  State<CourseEdit1> createState() => _CourseEdit1State();
}

class _CourseEdit1State extends State<CourseEdit1> {
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
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            onPressed: deleteCourse,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
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
                  onPressed: updateCourse,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Save'),
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
        builder: (context) => CourseEdit2(
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

  //create delete Log
  void createLogDelete(String data) async {
    try {
      String currentDateTime = DateTime.now().toString();
      await FirebaseFirestore.instance
          .collection('Log')
          .doc(currentDateTime)
          .set({
        'datetime': currentDateTime,
        'activity': 'Course deleted ($data)',
      });
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  //delete data
  void deleteCourse() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Delete Course',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          icon: const Icon(Icons.delete_outline_rounded),
          content: const Text(
              'This action cannot be undone. Are you sure want to delete?'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                try {
                  FirebaseFirestore.instance
                      .collection('Course')
                      .doc(widget.docID)
                      .delete();

                  //create log
                  createLogDelete(widget.docID);

                  //show message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Course deleted successfully',
                      ),
                    ),
                  );
                } on FirebaseException catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
                //clear fileds
                clearAllFields();

                //navigate to coursepage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(selectedIndex: 2),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //fetch data
  void fetchData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Course')
          .doc(widget.docID)
          .get();

      //data
      final courseData = snapshot.data() as Map<String, dynamic>;
      //fill data
      _semester.text = courseData['semester'];
      _subjectCode.text = courseData['subjectCode'];
      _subjectName.text = courseData['subjectName'];
      _shortName.text = courseData['shortName'];
      _isGPA.text = courseData['isGPA'];
      _credits.text = courseData['credits'];
      _isCompulsory.text = courseData['isCompulsory'];
      _lecturerName.text = courseData['lecturerName'];
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  //create log
  void createLog(String data) async {
    try {
      String currentDateTime = DateTime.now().toString();
      await FirebaseFirestore.instance
          .collection('Log')
          .doc(currentDateTime)
          .set({
        'datetime': currentDateTime,
        'activity': 'Course updated ($data)',
      });
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  //add to firebase
  void updateCourse() async {
    setState(() {
      isLoading = true;
      subCode = _subjectCode.text;
    });

    try {
      await FirebaseFirestore.instance
          .collection('Course')
          .doc(_subjectCode.text)
          .update({
        'semester': _semester.text,
        'subjectCode': _subjectCode.text,
        'subjectName': _subjectName.text,
        'shortName': _shortName.text,
        'isGPA': _isGPA.text,
        'credits': _credits.text,
        'isCompulsory': _isCompulsory.text,
        'lecturerName': _lecturerName.text,
      });

      //create log
      createLog(_subjectCode.text);

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
