import 'package:flutter/material.dart';

import '../../core/styles/colors.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final void Function()? function;


   DefaultTextButton({Key? key, required this.text, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: AppColors.defaultColor,
          ),
        ));
  }
}
