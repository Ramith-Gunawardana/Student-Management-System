import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_dropdown_menu.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/components/custom_text_form_field.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/controller/student_controller.dart';
import 'package:student_management_system/pages/student_add_2.dart';

class StudentAdd1 extends StatefulWidget {
  const StudentAdd1({super.key});

  @override
  State<StudentAdd1> createState() => _StudentAdd1State();
}

class _StudentAdd1State extends State<StudentAdd1> {
  //controller data
  final TextEditingController _intake = StudentControllerData().intake;
  final TextEditingController _studentType =
      StudentControllerData().studentType;
  final TextEditingController _studentCategory =
      StudentControllerData().studentCategory;
  final TextEditingController _degree = StudentControllerData().degree;
  final TextEditingController _fullName = StudentControllerData().fullName;
  final TextEditingController _nic = StudentControllerData().nic;
  final TextEditingController _dob = StudentControllerData().dob;
  final TextEditingController _gender = StudentControllerData().gender;
  final TextEditingController _mobile = StudentControllerData().mobile;

  //to show loading icon
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
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
                //intake
                CustomDropdownMenu(
                  hint: 'Intake',
                  entryList: intakes,
                  controller: _intake,
                ),
                const FormGap(),
                //type
                DropdownMenu(
                  dropdownMenuEntries: studentTypes,
                  width: screenWidth - 36,
                  hintText: 'Student Type',
                  controller: _studentType,
                  onSelected: (value) {
                    setState(() {
                      studentCatgories(_studentType);
                    });
                  },
                ),
                const FormGap(),
                //category
                CustomDropdownMenu(
                  hint: 'Student Category',
                  entryList: studentCatgories(_studentType),
                  controller: _studentCategory,
                ),
                const FormGap(),
                //degree
                CustomDropdownMenu(
                  controller: _degree,
                  hint: "Degree",
                  entryList: degrees,
                ),
                const FormGap(),
                //fullname
                CustomTextFormFiled(
                  hint: 'Full Name',
                  controller: _fullName,
                ),
                const FormGap(),
                //nic
                CustomTextFormFiled(
                  hint: 'NIC',
                  controller: _nic,
                ),
                const FormGap(),
                //date of birth
                TextFormField(
                  controller: _dob,
                  keyboardType: TextInputType.none,
                  canRequestFocus: false,
                  onTap: () async {
                    final DateTime? pickedDOB = await showDatePicker(
                      context: context,
                      firstDate: DateTime.utc(1970, 01, 01),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      helpText: 'Select Date of Birth',
                    );
                    if (pickedDOB != null) {
                      setState(() {
                        _dob.text = pickedDOB.toString().substring(0, 10);
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    hintText: 'Date of Birth',
                  ),
                ),
                const FormGap(),
                //gender
                CustomDropdownMenu(
                  hint: 'Gender',
                  entryList: genders,
                  controller: _gender,
                ),
                const FormGap(),
                CustomTextFormFiled(
                  hint: 'Mobile Number',
                  controller: _mobile,
                ),
                const FormGap(),
                //next button
                CustomFilledButton(
                  onPressed: addNewSudent,
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

  void goToNextPage(String email, String indexNumber, String intake,
      String degree, String regno) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentAdd2(
          email: email,
          indexNumber: indexNumber,
          intake: intake,
          degree: degree,
          regnoDocID: regno,
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
      _intake.clear();
      _studentType.clear();
      _studentCategory.clear();
      _degree.clear();
      _fullName.clear();
      _nic.clear();
      _dob.clear();
      _gender.clear();
      _mobile.clear();
    });
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
        'activity': 'New student added ($data)',
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
  void addNewSudent() async {
    String email = '';
    String newIndexNumber = '';
    String docIDIndex = '';

    setState(() {
      isLoading = true;
    });

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Student')
          .doc(_intake.text)
          .collection(_degree.text)
          .get();

      //calculate intake year for reg number
      int intakeYear = int.parse(_intake.text.split(' ')[1]) - 17;

      //check if students in the db are empty
      if (snapshot.docs.isEmpty) {
        //****0001******

        //check degree
        if (_degree.text == 'Software Engineering') {
          //email
          email = '${_intake.text.split(' ')[1]}-bse-0001@kdu.ac.lk';
          //index no
          newIndexNumber = 'D/BSE/$intakeYear/0001';
          //docID
          docIDIndex = 'D_BSE_${intakeYear}_0001';

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .set({
            'lastUpdated': DateTime.now(),
          });

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .collection(_degree.text)
              .doc(docIDIndex)
              .set({
            'intake': _intake.text,
            'studentType': _studentType.text,
            'studentCategory': _studentCategory.text,
            'degree': _degree.text,
            'regno': newIndexNumber,
            'fullname': _fullName.text,
            'nic': _nic.text,
            'dob': _dob.text,
            'gender': _gender.text,
            'mobile': _mobile.text,
            'email': email,
          });
          //add to log
          createLog(newIndexNumber);
        } else if (_degree.text == 'Computer Science') {
          //email
          email = '${_intake.text.split(' ')[1]}-bcs-0001@kdu.ac.lk';
          //index no
          newIndexNumber = 'D/BCS/$intakeYear/0001';
          //docID
          docIDIndex = 'D_BCS_${intakeYear}_0001';

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .set({
            'lastUpdated': DateTime.now(),
          });

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .collection(_degree.text)
              .doc(docIDIndex)
              .set({
            'intake': _intake.text,
            'studentType': _studentType.text,
            'studentCategory': _studentCategory.text,
            'degree': _degree.text,
            'regno': newIndexNumber,
            'fullname': _fullName.text,
            'nic': _nic.text,
            'dob': _dob.text,
            'gender': _gender.text,
            'mobile': _mobile.text,
            'email': email,
          });
          //add to log
          createLog(newIndexNumber);
        }
      } else {
        //already students in the db - from 0002
        int lastIndex = int.parse(snapshot.docs.last.id.split('_')[3]);
        String newIndexWithZeros = (lastIndex + 1).toString().padLeft(4, '0');

        //check degree
        if (_degree.text == 'Software Engineering') {
          //new index no
          newIndexNumber = 'D/BSE/$intakeYear/$newIndexWithZeros';
          //email
          email =
              '${_intake.text.split(' ')[1]}-bse-$newIndexWithZeros@kdu.ac.lk';
          //docID
          docIDIndex = 'D_BSE_${intakeYear}_$newIndexWithZeros';

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .set({
            'lastUpdated': DateTime.now(),
          });

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .collection(_degree.text)
              .doc(docIDIndex)
              .set({
            'intake': _intake.text,
            'studentType': _studentType.text,
            'studentCategory': _studentCategory.text,
            'degree': _degree.text,
            'regno': newIndexNumber,
            'fullname': _fullName.text,
            'nic': _nic.text,
            'dob': _dob.text,
            'gender': _gender.text,
            'mobile': _mobile.text,
            'email': email,
          });
          //add to log
          createLog(newIndexNumber);
        } else if (_degree.text == 'Computer Science') {
          //new index no
          newIndexNumber = 'D/BCS/$intakeYear/$newIndexWithZeros';
          //email
          email =
              '${_intake.text.split(' ')[1]}-bcs-$newIndexWithZeros@kdu.ac.lk';
          //docID
          docIDIndex = 'D_BCS_${intakeYear}_$newIndexWithZeros';

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .set({
            'lastUpdated': DateTime.now(),
          });

          await FirebaseFirestore.instance
              .collection('Student')
              .doc(_intake.text)
              .collection(_degree.text)
              .doc(docIDIndex)
              .set({
            'intake': _intake.text,
            'studentType': _studentType.text,
            'studentCategory': _studentCategory.text,
            'degree': _degree.text,
            'regno': newIndexNumber,
            'fullname': _fullName.text,
            'nic': _nic.text,
            'dob': _dob.text,
            'gender': _gender.text,
            'mobile': _mobile.text,
            'email': email,
          });
          //add to log
          createLog(newIndexNumber);
        }
      }
      //temp data
      String intake = _intake.text;
      String degree = _degree.text;

      //clear fields
      clearAllFields();
      //navigate to next page
      goToNextPage(email, newIndexNumber, intake, degree, docIDIndex);
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
