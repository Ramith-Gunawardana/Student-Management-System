// import 'package:flutter/material.dart';
// import 'package:student_management_system/pages/home.dart';

// class Dashboard extends StatelessWidget {
//   const Dashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //pages
//     final List<Widget> pages = <Widget>[
//       //home page
//       const Home(),
//       //students
//       const Home(),
//       //courses
//       const Home(),
//       //logs
//       const Home(),
//     ];

//     return Scaffold(
//       body: pages.elementAt(index),
//       bottomNavigationBar: NavigationBar(destinations: const [
//         NavigationDestination(
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//         NavigationDestination(
//             icon: Icon(Icons.people_alt_outlined), label: 'Students'),
//         NavigationDestination(
//             icon: Icon(Icons.menu_book_rounded), label: 'Courses'),
//         NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Log'),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:student_management_system/pages/courses_home.dart';
import 'package:student_management_system/pages/home.dart';
import 'package:student_management_system/pages/logs_home.dart';
import 'package:student_management_system/pages/students_home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //bottom nav bar index
  int _selectedIndex = 0;

  //pages
  final List<Widget> pages = <Widget>[
    //home page
    const Home(),
    //students
    const StudentsHome(),
    //courses
    const CoursesHome(),
    //logs
    const LogsHome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //naviage to page according to selected index
      body: SafeArea(
        child: pages.elementAt(_selectedIndex),
      ),

      //bottom nav bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: [
          //home
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          //students
          NavigationDestination(
            icon: Icon(
              Icons.people_alt_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Students',
            selectedIcon: Icon(
              Icons.people_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          //courses
          NavigationDestination(
            icon: Icon(
              Icons.menu_book_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Courses',
            selectedIcon: Icon(
              Icons.menu_book_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          //logs
          NavigationDestination(
            icon: Icon(
              Icons.history_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
            label: 'Log',
            selectedIcon: Icon(
              Icons.history_rounded,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
