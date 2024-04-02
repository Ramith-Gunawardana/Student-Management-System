import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_navigation_destination.dart';
import 'package:student_management_system/pages/course_add_1.dart';
import 'package:student_management_system/pages/courses_home.dart';
import 'package:student_management_system/pages/home.dart';
import 'package:student_management_system/pages/logs_home.dart';
import 'package:student_management_system/pages/student_add_1.dart';
import 'package:student_management_system/pages/students_home.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({super.key, required this.selectedIndex});
  int selectedIndex;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //bottom nav bar index
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

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
      //top app bar
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text(
                'Student Management System',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            )
          : null,
      //body - naviage to page according to selected index in nav bar
      body: SafeArea(
        child: pages.elementAt(_selectedIndex),
      ),

      //floating action button
      floatingActionButton: _selectedIndex == 0
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (_selectedIndex == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentAdd1(),
                    ),
                  );
                } else if (_selectedIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseAdd1(),
                    ),
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),

      //bottom nav bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: [
          //home
          CustomNavigationDestination(
            label: 'Home',
            icon: const AssetImage('assets/icons/home.png'),
            selectedIcon: const AssetImage('assets/icons/home_fill.png'),
          ),
          //students
          CustomNavigationDestination(
            label: 'Students',
            icon: const AssetImage('assets/icons/student.png'),
            selectedIcon: const AssetImage('assets/icons/student_fill.png'),
          ),
          //courses
          CustomNavigationDestination(
            label: 'Courses',
            icon: const AssetImage('assets/icons/course.png'),
            selectedIcon: const AssetImage('assets/icons/course_fill.png'),
          ),
          //logs
          CustomNavigationDestination(
            label: 'Log',
            icon: const AssetImage('assets/icons/log.png'),
            selectedIcon: const AssetImage('assets/icons/log.png'),
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
