import 'package:f3_wallet/screen/qrcode_page.dart';
import 'package:f3_wallet/services/lotus.dart';
import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/utils/confirmation.dart';
import 'package:flutter/material.dart';

import 'package:tuple/tuple.dart';

class SingleSendPage extends StatefulWidget {
  final String address;
  final String name;
  final BuildContext accountCtx;

  SingleSendPage(
      {required this.address, required this.name, required this.accountCtx});

  @override
  _SingleSendPageState createState() => _SingleSendPageState();
}

class _SingleSendPageState extends State<SingleSendPage> {
  final _formKey = GlobalKey<FormState>();
  String? _receiver;
  double _amount = 0;
  double accountBalance = 0;
  final _receiverController = TextEditingController();

  Future<void> _callGetBalance(String address) async {
    final data = await getBalance(address);
    if (mounted) setState(() => accountBalance = data);
  }

  @override
  void initState() {
    super.initState();
    _callGetBalance(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueMain,
        appBar: AppBar(
          backgroundColor: blueMain,
          title: const Text('Send'),
          centerTitle: true,
        ),
        body: ListView(
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
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Receiver',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () => {
                            setState(() async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QRViewExample()),
                              );
                              setState(() {
                                _receiver = result;
                              });
                              _receiverController.text = result;
                            })
                          },
                          icon: Icon(
                            Icons.qr_code_scanner,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        // initialValue: _receiver,
                        controller: _receiverController,
                        onChanged: (value) {
                          setState(() {
                            _receiver = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter receiver address',
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
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 30, 30, 39),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      'Amount',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _amount = double.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Please enter an amount',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 10),
                    child: Text(
                      'Balance: ${accountBalance.toString()}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
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
                  var _amountBig = BigInt.from(_amount);
                  _amountBig = _amountBig * BigInt.from(1e18);

                  final msg = await createSendMessageWithCid(
                    widget.address,
                    _receiver.toString(),
                    _amountBig.toString(),
                  );
                  showConfirmationDialog(
                      widget.address,
                      widget.name,
                      '${_amount.toString()} FIL',
                      msg,
                      {
                        'Payer': widget.address.toString(),
                        'Receiver': _receiver.toString(),
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
        )
        // Column(),

        );
  }

  @override
  void dispose() {
    _receiverController.dispose();
    super.dispose();
  }
}
