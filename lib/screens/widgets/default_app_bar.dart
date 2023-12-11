import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title ?? ''),
    leading: IconButton(
      icon: const Icon(
        IconBroken.Arrow___Left_2,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
  );
}