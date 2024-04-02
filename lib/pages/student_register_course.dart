import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_management_system/components/custom_dropdown_menu.dart';
import 'package:student_management_system/components/custom_filled_button.dart';
import 'package:student_management_system/components/custom_sized_box.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/pages/dashboard.dart';

class StudentRegisterCourse extends StatefulWidget {
  const StudentRegisterCourse({
    super.key,
    required this.intake,
    required this.degree,
    required this.regno,
  });
  final String intake;
  final String degree;
  final String regno;

  @override
  State<StudentRegisterCourse> createState() => _StudentRegisterCourseState();
}

class _StudentRegisterCourseState extends State<StudentRegisterCourse> {
  //controller
  final TextEditingController _semester = TextEditingController();
  //list of selected courses
  List<String> selectedCourses = [];
  //loading
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Course'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //semester
            DropdownMenu(
              dropdownMenuEntries: semesters,
              width: screenWidth - 36,
              hintText: 'Semseter',
              controller: _semester,
              onSelected: (value) async {
                setState(() {
                  //reset first
                  selectedCourses = [];

                  FirebaseFirestore.instance
                      .collection('Course')
                      .where('semester', isEqualTo: _semester.text)
                      .snapshots();
                });
              },
            ),
            const FormGap(),
            Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Course')
                      .where('semester', isEqualTo: _semester.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error fetching data: ${snapshot.error}');
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No course data available.'));
                    } else {
                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          final courseData =
                              document.data() as Map<String, dynamic>;

                          //add to list
                          selectedCourses.add(courseData['subjectCode']);

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                              ),
                              child: ListTile(
                                title: Text(
                                  '${courseData['subjectName']} (${courseData['shortName']})',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      courseData['subjectCode'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      '${courseData['isGPA']} - ${courseData['credits']} Credits',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                                trailing:
                                    courseData['isCompulsory'] == 'Compulsory'
                                        ? Text(
                                            'C',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          )
                                        : Text(
                                            'E',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
            const FormGap(),
            //register courses
            CustomFilledButton(
              onPressed: registerCourses,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Register Courses'),
            )
          ],
        ),
      ),
    );
  }

  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(selectedIndex: 1),
      ),
    );
  }

  void registerCourses() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('Student')
          .doc(widget.intake)
          .collection(widget.degree)
          .doc(widget.regno)
          .update({
        _semester.text: FieldValue.arrayUnion(selectedCourses),
      });

      //show succes message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student added succssfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      //navigate to students homepage
      goToNextPage();
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
