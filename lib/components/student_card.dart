import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    Future<List<DocumentSnapshot>> getStudentData() async {
      //student list
      List<QueryDocumentSnapshot<Map<String, dynamic>>> studentsList = [];

      final snapshot =
          await FirebaseFirestore.instance.collection('Student').get();

      //intakes
      for (var doc in snapshot.docs) {
        //se
        final snapshot1 = await FirebaseFirestore.instance
            .collection('Student')
            .doc(doc.id)
            .collection('Software Engineering')
            .get();
        studentsList.addAll(snapshot1.docs);

        //cs
        final snapshot3 = await FirebaseFirestore.instance
            .collection('Student')
            .doc(doc.id)
            .collection('Computer Science')
            .get();
        studentsList.addAll(snapshot3.docs);
      }
      return studentsList;
    }

    return SingleChildScrollView(
      child: FutureBuilder(
        future: getStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching data: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No student data available.'));
          } else {
            var students = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                itemCount: students.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  var studentData =
                      students[index].data() as Map<String, dynamic>;

                  //search results - if not found hide
                  if (!studentData['nic']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase()) &&
                      !studentData['fullname']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase()) &&
                      !studentData['regno']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase())) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: ListTile(
                        title: Text(
                          studentData['regno'],
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              studentData['fullname'],
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              '${studentData['nic']}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        trailing: studentData['degree'] ==
                                'Software Engineering'
                            ? Text(
                                'SE',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : Text(
                                'CS',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
