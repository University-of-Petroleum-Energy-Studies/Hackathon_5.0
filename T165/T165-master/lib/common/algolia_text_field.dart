import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlgoliaTextField extends StatelessWidget {
  final Function onChanged;
  final Function onTap;
  final String label;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLength;
  final TextStyle textStyle;

  const AlgoliaTextField(
      {this.label,
      this.textStyle,
      this.suffixIcon,
      this.onChanged,
      this.prefixIcon,
      this.onTap,
      this.initialValue,
      this.readOnly,
      this.controller,
      this.keyboardType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black,
      ),
      child: TextFormField(
        style: textStyle ??
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        onChanged: onChanged,
        onTap: onTap,
        maxLength: maxLength,
        keyboardType: keyboardType ?? TextInputType.text,
        initialValue: initialValue,
        controller: controller,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
