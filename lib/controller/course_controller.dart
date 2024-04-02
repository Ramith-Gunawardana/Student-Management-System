import 'package:flutter/material.dart';

class CourseControllerData {
  TextEditingController semester = TextEditingController();
  TextEditingController subjectCode = TextEditingController();
  TextEditingController subjectName = TextEditingController();
  TextEditingController shortName = TextEditingController();
  TextEditingController isGPA = TextEditingController();
  TextEditingController credits = TextEditingController();
  TextEditingController isCompulsory = TextEditingController();
  TextEditingController lecturerName = TextEditingController();

  // Singleton pattern for accessing the instance
  static final CourseControllerData _instance =
      CourseControllerData._internal();

  factory CourseControllerData() {
    return _instance;
  }

  CourseControllerData._internal();
}
