import 'package:flutter/material.dart';

//intakes
List<DropdownMenuEntry<String>> intakes = [
  const DropdownMenuEntry(value: '41', label: 'Intake 41'),
  const DropdownMenuEntry(value: '40', label: 'Intake 40'),
  const DropdownMenuEntry(value: '39', label: 'Intake 39'),
  const DropdownMenuEntry(value: '38', label: 'Intake 38'),
];

//degrees
List<DropdownMenuEntry<String>> degreesShort = [
  const DropdownMenuEntry(value: 'se', label: 'SE'),
  const DropdownMenuEntry(value: 'cs', label: 'CS'),
];
List<DropdownMenuEntry<String>> degrees = [
  const DropdownMenuEntry(value: 'se', label: 'Software Engineering'),
  const DropdownMenuEntry(value: 'cs', label: 'Computer Science'),
];

//student types
List<DropdownMenuEntry<String>> studentTypes = [
  const DropdownMenuEntry(value: 'ds', label: 'Dayscholar'),
  const DropdownMenuEntry(value: 'oc', label: 'Officer Cadet'),
];

//student categories
List<DropdownMenuEntry<String>> studentCatgories(
    TextEditingController studentType) {
  switch (studentType.text) {
    case 'Dayscholar':
      return [
        const DropdownMenuEntry(value: 'civil', label: 'Civil'),
      ];
    case 'Officer Cadet':
      return [
        const DropdownMenuEntry(value: 'army', label: 'Army'),
        const DropdownMenuEntry(value: 'navy', label: 'Navy'),
        const DropdownMenuEntry(value: 'airforce', label: 'Air Force'),
      ];
    default:
      return [
        const DropdownMenuEntry(
          value: 'null',
          label: 'Please select Student Type',
          enabled: false,
        )
      ];
  }
}

//gender
List<DropdownMenuEntry<String>> genders = [
  const DropdownMenuEntry(value: 'male', label: 'Male'),
  const DropdownMenuEntry(value: 'female', label: 'Female'),
];

//semseters
List<DropdownMenuEntry<String>> semesters = [
  const DropdownMenuEntry(value: 'sem1', label: 'Semester 1'),
  const DropdownMenuEntry(value: 'sem2', label: 'Semester 2'),
  const DropdownMenuEntry(value: 'sem3', label: 'Semester 3'),
  const DropdownMenuEntry(value: 'sem4', label: 'Semester 4'),
  const DropdownMenuEntry(value: 'sem5', label: 'Semester 5'),
  const DropdownMenuEntry(value: 'sem6', label: 'Semester 6'),
  const DropdownMenuEntry(value: 'sem7', label: 'Semester 7'),
  const DropdownMenuEntry(value: 'sem8', label: 'Semester 8'),
];

//gpa / ngpa
List<DropdownMenuEntry<String>> isGPA = [
  const DropdownMenuEntry(value: 'gpa', label: 'GPA'),
  const DropdownMenuEntry(value: 'ngpa', label: 'NGPA'),
];

//compusory / elective
List<DropdownMenuEntry<String>> isCompulsory = [
  const DropdownMenuEntry(value: 'c', label: 'Compulsory'),
  const DropdownMenuEntry(value: 'e', label: 'Elective'),
];
