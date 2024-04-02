import 'package:flutter/material.dart';

class StudentControllerData {
  TextEditingController intake = TextEditingController();
  TextEditingController studentType = TextEditingController();
  TextEditingController studentCategory = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController nic = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController mobile = TextEditingController();

  // Singleton pattern for accessing the instance
  static final StudentControllerData _instance =
      StudentControllerData._internal();

  factory StudentControllerData() {
    return _instance;
  }

  StudentControllerData._internal();
}
