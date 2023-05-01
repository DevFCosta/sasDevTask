import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:house_rules/components/add_rule_modal.dart';
import 'package:house_rules/components/delete_modal.dart';
import 'package:house_rules/components/edit_modal.dart';
import 'package:house_rules/components/show_modal.dart';
import 'package:house_rules/data/constants.dart';

import 'package:http/http.dart' as http;

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Center(child: Text('HOUSE RULES')),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 85),
                  child: RefreshIndicator(
                    onRefresh: () => getRules(countPage),
                    child: ListView.builder(
                        itemCount: allData.length,
                        controller: _controller,
                        itemBuilder: (_, index) {
                          final rulesData = allData[index] as Map;
                          final ruleId = rulesData['id'].toString();
                          final ruleName = rulesData['name'];
                          return ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    rulesData['id'].toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            title: Text('Name: ${rulesData['name']}'),
                            subtitle: Text('Active: ${rulesData['active']}'),
                            trailing: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: MyModalDelete(
                                              ruleID: ruleId,
                                            ));
                                      });
                                } else if (value == 'edit') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: MyEditModal(
                                              ruleID: ruleId,
                                              ruleName: ruleName,
                                            ));
                                      });
                                } else if (value == 'show') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: MyShowModal(
                                              ruleID: ruleId,
                                            ));
                                      });
                                }
                              },
                              color: Colors.blue,
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                      value: 'show', child: Text('Show')),
                                  const PopupMenuItem(
                                      value: 'delete', child: Text('Delete'))
                                ];
                              },
                            ),
                          );
                        }),
                  ))),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              if (countPage == totalPage) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Thats all the Data'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: ':)',
                    onPressed: () {},
                  ),
                ));
              } else {
                load();
              }
            },
            label: const Text(
              'load more',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.autorenew,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            elevation: 5,
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: MyAddModal());
                  });
            },
            label: const Text(
              'Add Rule',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
            elevation: 5,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List data = [];
  List allData = [];

  bool firstTimeLoading = false;
  bool hasMore = true;
  bool loadingMore = false;
  int countPage = 1;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getRules(countPage);
    _controller = ScrollController()
      ..addListener(() {
        loadingMore;
      });
  }

  void load() async {
    if (hasMore == true &&
        firstTimeLoading == false &&
        loadingMore == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        loadingMore = true;
      });

      countPage += 1;
      getRules(countPage);
    }
    setState(() {
      loadingMore = false;
    });

    print(countPage);
  }

  int? totalPage;
  int? currentPage;

  Future<void> getRules(int page) async {
    final listUrl = ApiConstants.list;
    final url = ('$listUrl?page=$page');
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {"Authorization": ApiConstants.authorization},
    );
    print(response.body);
    var json = jsonDecode(response.body) as Map;
    final Map paginationInfo = json['data']['pagination'];
    print(paginationInfo);
    final List allRulesFetch = json['data']['entities'];
    if (allRulesFetch.isNotEmpty && paginationInfo.isNotEmpty) {
      setState(() {
        allData.addAll(allRulesFetch);
        totalPage = paginationInfo['total_pages'];
        currentPage = paginationInfo['current_page'];
      });
    } else {
      setState(() {
        hasMore = false;
      });
    }
  }
}
