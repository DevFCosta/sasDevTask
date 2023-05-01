import 'package:flutter/material.dart';

class MyTextFieldPassword extends StatefulWidget {
  final controller;
  final String hintText;
  final int inputLength;

  const MyTextFieldPassword({
    super.key,
    required this.controller,
    required this.hintText,
    required this.inputLength,
  });

  @override
  State<MyTextFieldPassword> createState() => _MyTextFieldPasswordState();
}

class _MyTextFieldPasswordState extends State<MyTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _isHidden ? false : true,
        maxLength: widget.inputLength,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIconColor: const Color(0xfff45424),
            suffixIcon: IconButton(
              icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                updatePasswordStatus();
              },
            )),
      ),
    );
  }

  bool _isHidden = false;
  void updatePasswordStatus() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
