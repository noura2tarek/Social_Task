import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextInputType type;
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final IconData? preficon;
  final IconData? sufficon;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? prefixColor;
  final double? prefixIconSize;
  final void Function()? suffixPreesed;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final TextStyle? style;
  final bool isObsecure;
  final void Function()? onTab;

  const DefaultFormField({
    super.key,
    required this.type,
    required this.controller,
    this.label,
    this.hint,
    this.preficon,
    this.sufficon,
    this.validator,
    this.fillColor,
    this.labelColor,
    this.hintColor,
    this.cursorColor,
    this.prefixColor,
    this.prefixIconSize,
    this.suffixPreesed,
    this.onSubmit,
    this.onChange,
    this.style,
    this.isObsecure = false,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.0,
      child: TextFormField(
        style: style,
        keyboardType: type,
        controller: controller,
        validator: validator,
        obscureText: isObsecure,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          fillColor: fillColor,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
          ),
          prefixIcon: Icon(
            preficon,
            color: prefixColor,
            size: prefixIconSize,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              sufficon,
            ),
            onPressed: suffixPreesed,
          ),
        ),
        onTap: onTab,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
      ),
    );
  }
}
