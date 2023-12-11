import 'package:flutter/material.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Divider(
      height: 1.0,
      indent: 15.0,
      endIndent: 15.0,
      color: Colors.grey[350],
    );
  }
}
