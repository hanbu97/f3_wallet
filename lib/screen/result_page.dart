import 'dart:convert';

import 'package:f3_wallet/ffi.io.dart';
import 'package:f3_wallet/screen/account_page.dart';
import 'package:f3_wallet/screen/error_page.dart';
import 'package:f3_wallet/screen/loading_page.dart';
import 'package:f3_wallet/services/lotus.dart';
import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/services/lotus_result.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/shared/encryption.dart';
import 'package:f3_wallet/widget/verify_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';

class MessageResultPage extends StatefulWidget {
  final String name;
  final String address;
  final String messageCid;

  const MessageResultPage(
      {super.key,
      required this.name,
      required this.address,
      required this.messageCid});

  @override
  State<MessageResultPage> createState() => _MessageResultPageState();
}

class _MessageResultPageState extends State<MessageResultPage> {
  Map<String, Object?>? _fetchItems;

  Future<void> getMessageResult() async {
    var res = await stateWaitMsg(widget.messageCid);
    res ??= {};

    setState(() {
      _fetchItems = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getMessageResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueMain,
        appBar: AppBar(
          backgroundColor: blueMain,
          title: const Text('Message Result'),
          centerTitle: true,
        ),
        body: _fetchItems == null
            ? LoadingPage()
            : ListView(
                children: [
                  Column(
                    children: [
                      ..._fetchItems!.keys.map((key) => Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, right: 5),
                                padding: const EdgeInsets.all(8),
                                color: const Color.fromARGB(255, 30, 30, 39),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            key,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.content_copy,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: _fetchItems![key]
                                                      .toString()));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content:
                                                        Text(key + ' copied')),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          initialValue:
                                              _fetchItems![key].toString(),
                                          // enabled: false,
                                          decoration: const InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      220, 220, 220, 1)),
                                            ),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 100,
                      ),
                      const SizedBox(height: 100),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.black,
                              minimumSize: const Size.fromHeight(50), // NEW
                              backgroundColor: yellowStartWallet),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountPage(
                                  address: widget.address,
                                  name: widget.name,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Finish',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }
}
