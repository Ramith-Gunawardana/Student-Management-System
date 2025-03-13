import 'package:flutter/material.dart';
import 'package:student_management_system/components/custom_icon_button.dart';
import 'package:student_management_system/pages/course_add_1.dart';
import 'package:student_management_system/pages/dashboard.dart';
import 'package:student_management_system/pages/student_add_1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //screen height and width
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
        top: 6,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo and kdu
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/kdu-logo.png'),
                height: 50,
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                'General Sir John Kotelawala \nDefence University',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          // const SizedBox(
          //   height: 24,
          // ),
          //welcome msg and signout button
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Row(
          //       children: [
          //         Text('Welcome, '),
          //         Text('Admin'),
          //       ],
          //     ),
          //     //signout button
          //     FilledButton(
          //       onPressed: () {},
          //       style: ButtonStyle(
          //         backgroundColor: MaterialStatePropertyAll(
          //             Theme.of(context).colorScheme.primaryContainer),
          //         foregroundColor: MaterialStatePropertyAll(
          //             Theme.of(context).colorScheme.primary),
          //         shape: const MaterialStatePropertyAll(
          //           RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(
          //               Radius.circular(10),
          //             ),
          //           ),
          //         ),
          //       ),
          //       child: const Text('Signout'),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 24,
          // ),
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          //buttons grid
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      icon: Icon(
                        Icons.people_outline_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'View all Students',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(selectedIndex: 1),
                          ),
                        );
                      },
                      height: screenHeight,
                      width: screenWidth,
                    ),
                    CustomIconButton(
                      icon: Icon(
                        Icons.person_add_alt,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'Add new Student',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentAdd1(),
                          ),
                        );
                      },
                      height: screenHeight,
                      width: screenWidth,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomIconButton(
                      icon: ImageIcon(
                        const AssetImage(
                          'assets/icons/course.png',
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'View all Courses',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(selectedIndex: 2),
                          ),
                        );
                      },
                      height: screenHeight,
                      width: screenWidth,
                    ),
                    CustomIconButton(
                      icon: ImageIcon(
                        const AssetImage('assets/icons/addcourse.png'),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: 'Add new Course',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseAdd1(),
                          ),
                        );
                      },
                      height: screenHeight,
                      width: screenWidth,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 24,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomIconButton(
                //       icon:
                //           const ImageIcon(AssetImage('assets/icons/admin.png')),
                //       label: 'Add new Admin',
                //       onPressed: () {},
                //       height: screenHeight,
                //       width: screenWidth,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
