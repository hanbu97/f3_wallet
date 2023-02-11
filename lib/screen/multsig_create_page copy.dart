import 'dart:convert';

import 'package:f3_wallet/ffi.io.dart';
import 'package:f3_wallet/screen/qrcode_page.dart';
import 'package:f3_wallet/services/lotus.dart';
import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/shared/encryption.dart';
import 'package:f3_wallet/widget/verify_password.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';

class CreateMultisig extends StatefulWidget {
  final String address;
  final String name;
  const CreateMultisig({
    super.key,
    required this.address,
    required this.name,
  });

  @override
  State<CreateMultisig> createState() => _CreateMultisigState();
}

class _CreateMultisigState extends State<CreateMultisig> {
  final _formKey = GlobalKey<FormState>();
  int _threshold = 0;
  List<String> _signers = [];
  List<TextEditingController> _signersController = [];
  double _amount = 0;
  double accountBalance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signers.add(widget.address);
    _signersController.add(TextEditingController());
    _signersController[0].text = widget.address;
  }

  void _showVerifyPasswordDialog(
      String name, String address, Tuple2<Map<String, Object?>, String> msg) {
    showDialog(
      context: context,
      builder: (context) {
        return VerifyPassword(
          name: name,
          address: address,
          msg: msg,
        );
      },
    );
  }

  void _showConfirmationDialog(Tuple2<Map<String, Object?>, String> msg) {
    // void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: blueMain,
          appBar: AppBar(
            title: const Text("Creat Confirm"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: blueMain,
          ),
          body: ListView(
            children: [
              Container(
                height: _signers.length * 150 + 100,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'From',
                                // textBaseline: TextBaseline.alphabetic,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                              child: Text(
                                '${widget.address}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                                child: const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Threshold',
                                // textBaseline: TextBaseline.alphabetic,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                              child: Text(
                                '${_threshold}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                                child: const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Signers',
                                // textBaseline: TextBaseline.alphabetic,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ..._signers
                                    .asMap()
                                    .entries
                                    .map((entry) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            '${_signers[entry.key]}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        )),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                  backgroundColor: yellowStartWallet),
              onPressed: () {
                _showVerifyPasswordDialog(widget.name, widget.address, msg);
              },
              child: const Text(
                'Confirm Create',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueMain,
        appBar: AppBar(
          backgroundColor: blueMain,
          title: Text('Create Multisig'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.all(8),
                    color: Color.fromARGB(255, 30, 30, 39),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: const Text(
                            'Threshold',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _threshold = int.parse(value);
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter signer threshold',
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(220, 220, 220, 1)),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    padding: EdgeInsets.all(8),
                    color: Color.fromARGB(255, 30, 30, 39),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Signers',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(25.0),
                                highlightColor: Colors.white,
                                splashColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    _signers.add('');
                                    _signersController
                                        .add(TextEditingController());
                                  });
                                  print(_signers);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right: 15, top: 20, left: 20, bottom: 20),
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ..._signers.asMap().entries.map((entry) => Container(
                              padding: EdgeInsets.only(left: 10),
                              child: TextFormField(
                                // initialValue: _signers[entry.key],
                                controller: _signersController[entry.key],
                                onChanged: (value) {
                                  setState(() {
                                    _signers[entry.key] = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter signer address',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(220, 220, 220, 1)),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.qr_code_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QRViewExample()),
                                      );
                                      setState(() {
                                        _signers[entry.key] = result;
                                      });
                                      _signersController[entry.key].text =
                                          result;
                                    },
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
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
                        // generate create multisig wallet message
                        if (_threshold > _signers.length) {
                          return;
                        }

                        final msg = await createMsigCreateMessage(
                            widget.address, _signers, _threshold);

                        // cofirm before sign
                        _showConfirmationDialog(msg);
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
