import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color borderColor;
  final bool isUpperCase;
  final double radius;
  final String text;
  final Function function;

  DefaultButton({
    super.key,
    this.width = double.infinity,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.isUpperCase = true,
    this.radius = 7.0,
    required this.text,
    required this.function,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 42.0,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
