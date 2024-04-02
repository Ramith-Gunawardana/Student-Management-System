import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.height,
    required this.width,
    required this.onPressed,
  });
  Widget icon;
  String label;
  double height;
  double width;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.14,
      width: width * 0.4,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primaryContainer),
          foregroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
