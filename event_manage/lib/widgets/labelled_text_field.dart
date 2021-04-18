import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LabelledTextField extends StatelessWidget {
  final String labelledtext;
  final Function onChanged;
  final IconData preIcon;
  final bool obscureText;
  final Color color;
  LabelledTextField({
    this.labelledtext,
    this.onChanged,
    this.preIcon,
    this.obscureText,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Colors.blue[800],
      decoration: InputDecoration(
        labelText: labelledtext,
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(
          preIcon,
        size: 16,
        color: color,
        ),
        filled: true,

        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }
}
