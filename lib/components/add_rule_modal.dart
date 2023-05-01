import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rules/components/my_text_field.dart';
import 'package:house_rules/data/constants.dart';
import 'package:house_rules/pages/mainPage.dart';
import 'package:http/http.dart' as http;

class MyAddModal extends StatefulWidget {
  const MyAddModal({super.key});

  @override
  State<MyAddModal> createState() => _MyAddModalState();
}

class _MyAddModalState extends State<MyAddModal> {
  final TextEditingController ruleName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Text(
              'Add New Rule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          MyTextField(
              controller: ruleName,
              hintText: 'Rule',
              obscureText: false,
              inputLength: 25),
          ElevatedButton(
              onPressed: () {
                createRule();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyMainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }

  Future<void> createRule() async {
    final body = jsonEncode({
      "house_rules": {"name": ruleName.text, "active": 1}
    });
    final url = ApiConstants.create;
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: body,
      headers: {"Authorization": ApiConstants.authorization},
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
