import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({
  String labelText,
  String hintText,
}) {
  return InputDecoration(
    fillColor: const Color(0xFFF6F6F6),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: Colors.blueAccent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(
        color: Color(0xFF69639F),
        width: 2.0,
      ),
    ),
    labelText: labelText,
    labelStyle: TextStyle(fontFamily: 'ArialRounded'),
    hintText: hintText,
    hintStyle: TextStyle(fontFamily: 'ArialRounded'),
    contentPadding: EdgeInsets.symmetric(horizontal: 14.0),
  );
}
