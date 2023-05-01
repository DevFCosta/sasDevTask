import 'package:flutter/material.dart';
import 'package:house_rules/data/constants.dart';
import 'package:house_rules/pages/mainPage.dart';
import 'package:http/http.dart' as http;

class MyModalDelete extends StatefulWidget {
  const MyModalDelete({super.key, required this.ruleID});
  final String ruleID;

  @override
  State<MyModalDelete> createState() => _MyModalDeleteState();
}

class _MyModalDeleteState extends State<MyModalDelete> {
  final TextEditingController ruleName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Text(
              'Delete Rule',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              'Are you sure to\n remove this rule?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Dimiss',
                      style: TextStyle(fontSize: 16),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      deleteRule(widget.ruleID);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyMainPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Sure',
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> deleteRule(String id) async {
    final url = ApiConstants.delete + id;
    final uri = Uri.parse(url);
    final response = await http.delete(
      uri,
      headers: {"Authorization": ApiConstants.authorization},
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
