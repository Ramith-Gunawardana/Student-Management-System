import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LogCard extends StatelessWidget {
  const LogCard({super.key, required this.searchKeyword});
  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Log')
          .orderBy(
            'datetime',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error fetching data: ${snapshot.error}');
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No log data available.'));
        } else {
          return Expanded(
            child: SizedBox(
              height: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  final courseData = document.data() as Map<String, dynamic>;

                  //search results - if not found hide
                  if (!courseData['datetime']
                          .toLowerCase()
                          .contains(searchKeyword.toLowerCase()) &&
                      !courseData['activity']
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
                          '${courseData['activity']}',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        subtitle: Text(
                          courseData['datetime'],
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
