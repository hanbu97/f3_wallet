import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/widget/verify_password.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class MultisigSend extends StatefulWidget {
  final String address;
  final String name;
  const MultisigSend({
    super.key,
    required this.address,
    required this.name,
  });

  @override
  State<MultisigSend> createState() => _MultisigSendState();
}

class _MultisigSendState extends State<MultisigSend> {
  final _formKey = GlobalKey<FormState>();
  String _receiver = "";
  String _sender = "";
  double _amount = 0;
  double accountBalance = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _signers.add(widget.address);
  // }

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
            title: const Text("Transaction Details"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: blueMain,
          ),
          body: Container(
            height: 1000,
            child: Column(
              children: [
                Container(),
                // const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    '${_amount.toString()} FIL',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),

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
                            'Payer',
                            // textBaseline: TextBaseline.alphabetic,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )),
                      ),
                      Expanded(
                        flex: 16,
                        child: Container(
                          child: Text(
                            '${widget.address}',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                            'Receiver',
                            // textBaseline: TextBaseline.alphabetic,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )),
                      ),
                      Expanded(
                        flex: 16,
                        child: Text(
                          _receiver,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                'Confirm Payment',
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
          title: const Text('Multisig Send'),
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
                            'Sender(Multisig)',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _sender = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter multisig sender address',
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
                            'Receiver',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
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
                            'Amount',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
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
                        var _amountBig = BigInt.from(_amount);
                        _amountBig = _amountBig * BigInt.from(1e18);

                        final msg = await createMsigSendMessage(_sender,
                            _receiver, _amountBig.toString(), widget.address);
                        // cofirm before  sign
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
