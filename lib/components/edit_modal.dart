import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rules/components/my_text_field.dart';
import 'package:house_rules/data/constants.dart';
import 'package:house_rules/pages/mainPage.dart';
import 'package:http/http.dart' as http;

class MyEditModal extends StatefulWidget {
  const MyEditModal({super.key, required this.ruleID, required this.ruleName});
  final String ruleID;
  final String ruleName;

  @override
  State<MyEditModal> createState() => _MyEditModalState();
}

class _MyEditModalState extends State<MyEditModal> {
  final TextEditingController newRuleName = TextEditingController();
  @override
  void initState() {
    newRuleName.text = widget.ruleName;
    super.initState();
  }

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
              'Edit Rule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          MyTextField(
              controller: newRuleName,
              hintText: 'Rule',
              obscureText: false,
              inputLength: 25),
          ElevatedButton(
              onPressed: () {
                editRule();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyMainPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }

  Future<void> editRule() async {
    final rule = newRuleName.text;
    final body = jsonEncode({
      "house_rules": {"name": newRuleName.text, "active": 0}
    });
    final url = ApiConstants.update + widget.ruleID;
    final uri = Uri.parse(url);
    final response = await http.put(
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
