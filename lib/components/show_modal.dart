import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:house_rules/data/constants.dart';
import 'package:http/http.dart' as http;

class MyShowModal extends StatefulWidget {
  const MyShowModal({super.key, required this.ruleID});
  final String ruleID;

  @override
  State<MyShowModal> createState() => _MyShowModalState();
}

class _MyShowModalState extends State<MyShowModal> {
  @override
  void initState() {
    super.initState();
    getAboutRules();
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
              'About Rule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Id: $id',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Name: $name',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Active: $active',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Dimiss',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }

  String? id;
  String? name;
  String? active;

  Future<void> getAboutRules() async {
    final url = ApiConstants.show + widget.ruleID;
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {"Authorization": ApiConstants.authorization},
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map;
      setState(() {
        id = json['data']['id'].toString();
        name = json['data']['name'].toString();
        active = json['data']['active'].toString();
      });
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
