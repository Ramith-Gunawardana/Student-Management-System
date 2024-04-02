import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  CustomFilledButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth,
      height: 54,
      child: FilledButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
