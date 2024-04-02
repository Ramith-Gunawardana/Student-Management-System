import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropdownMenu extends StatelessWidget {
  CustomDropdownMenu({
    super.key,
    required this.controller,
    required this.hint,
    required this.entryList,
  });

  final TextEditingController controller;
  final String hint;
  List<DropdownMenuEntry<String>> entryList;

  @override
  Widget build(BuildContext context) {
    //screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return DropdownMenu(
      dropdownMenuEntries: entryList,
      width: screenWidth - 36,
      hintText: hint,
      controller: controller,
    );
  }
}
