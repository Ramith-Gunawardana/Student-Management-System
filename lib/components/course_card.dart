import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Course').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching data: ${snapshot.error}');
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No course data available.'));
          } else {
            return SizedBox(
              height: double.maxFinite,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final courseData = document.data() as Map<String, dynamic>;

                  //search results - if not found hide
                  if (!courseData['subjectCode']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase()) &&
                      !courseData['subjectName']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase()) &&
                      !courseData['shortName']
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
                          '${courseData['subjectName']} (${courseData['shortName']})',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              courseData['subjectCode'],
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              '${courseData['isGPA']} - ${courseData['credits']} Credits',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        trailing: courseData['isCompulsory'] == 'Compulsory'
                            ? Text(
                                'C',
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : Text(
                                'E',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
