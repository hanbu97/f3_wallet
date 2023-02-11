import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/utils/confirmation.dart';
import 'package:flutter/material.dart';

class MultisigCancel extends StatefulWidget {
  final String address;
  final String name;
  const MultisigCancel({
    super.key,
    required this.address,
    required this.name,
  });

  @override
  State<MultisigCancel> createState() => _MultisigCancelState();
}

class _MultisigCancelState extends State<MultisigCancel> {
  final _formKey = GlobalKey<FormState>();
  int _txnid = -1;
  String _multisig = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueMain,
        appBar: AppBar(
          backgroundColor: blueMain,
          title: const Text('Multisig Cancel'),
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
                            'Multisig Address',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _multisig = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter multisig address',
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
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: const Text(
                            'Transaction ID',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _txnid = int.parse(value);
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter transaction id',
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(220, 220, 220, 1)),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
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
                        final msg = await createMsigCancelMessage(
                            _multisig, _txnid, widget.address);

                        // cofirm before  sign
                        showConfirmationDialog(
                            widget.address,
                            widget.name,
                            'TxnID  ${_txnid.toString()}',
                            msg,
                            {
                              'Signer': widget.address.toString(),
                              'Multisig Account': _multisig,
                            },
                            context);
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
