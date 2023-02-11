import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:f3_wallet/off_topic_code.dart';
import 'package:f3_wallet/screen/multsig_approve_page.dart';
import 'package:f3_wallet/screen/multsig_cancel_page.dart';
import 'package:f3_wallet/screen/multsig_create_page%20copy.dart';
import 'package:f3_wallet/screen/multsig_cancel_page.dart';
import 'package:f3_wallet/screen/home_view.dart';
import 'package:f3_wallet/screen/multsig_send_page%20copy.dart';
import 'package:f3_wallet/screen/result_page.dart';
import 'package:f3_wallet/screen/transfer_page.dart';
import 'package:f3_wallet/services/lotus.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/widget/asset_card.dart';
import 'package:f3_wallet/widget/sign_message.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:timer_builder/timer_builder.dart';

class AccountPage extends StatefulWidget {
  final String address;
  final String name;
  // const AccountPage({super.key});
  AccountPage({required this.address, required this.name});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List _currency = [];
  double account_balance = 0;

  Future<void> _callGetBalance(String address) async {
    final data = await getBalance(address);
    if (mounted) setState(() => account_balance = data);
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/currency.json');
    final data = await json.decode(response);

    setState(() {
      _currency = data['currency'];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();

    Future.delayed(const Duration(milliseconds: 500) * 5, () {
      if (!mounted) {
        return;
      }
    });
  }

  _showWalletAddress() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // padding: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: QrImage(
                  data: widget.address,
                  size: 200,
                ),
              ),
              Container(
                color: Colors.grey[100],
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(widget.address),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {
                            // TODO: save QR code to local
                          },
                          child: Text('Save QR Code'),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.address));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Address copied')),
                            );
                          },
                          child: Text('Copy Address'),
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
            ],
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
        elevation: 0,
        backgroundColor: blueMain,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: 'F3 Wallet',
                          )),
                );
              }),
        ),
        centerTitle: true,
        title: Text(widget.name, style: TextStyle(color: appBarItemsColor)),
      ),
      // body: Column(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: blueMain,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [yellowStart, yellowEnd],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Current balance',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Text(
                                    'USD',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  BalanceWidget(address: widget.address)
                                ],
                              ),
                              const SizedBox(height: 35),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        widget.address.substring(0, 15) + '...',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.content_copy,
                                            color: Colors.white),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                              text: widget.address));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Address copied')),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: IconButton(
                                      iconSize: 40,
                                      icon: Icon(Icons.qr_code,
                                          color: Colors.white),
                                      onPressed: () {
                                        _showWalletAddress();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: 15,
                        margin: EdgeInsets.only(bottom: 40),
                        decoration: BoxDecoration(
                          color: yellowSecondContainer,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInLeft(
                        child: _sendReceive(context,
                            title: 'Send',
                            icon: Icon(Icons.arrow_upward,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                    const SizedBox(
                      width: 20,
                    ),
                    FadeInDown(
                        child: _sendReceive(context,
                            title: 'Receive',
                            icon: Icon(Icons.arrow_downward,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                    const SizedBox(
                      width: 20,
                    ),
                    // FadeInUp(
                    //     child: _sendReceive(context,
                    //         title: 'Buy',
                    //         icon: Icon(Icons.badge,
                    //             size: 30, color: Colors.grey[400]))),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    FadeInRight(
                        child: _sendReceive(context,
                            title: 'Sign',
                            icon: Icon(Icons.edit,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _viewAll(title: 'MultiSig'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInLeft(
                        child: _sendReceive(context,
                            title: 'Create',
                            icon: Icon(Icons.add,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                    const SizedBox(
                      width: 20,
                    ),
                    FadeInLeft(
                        child: _sendReceive(context,
                            title: 'MultiSend',
                            icon: Icon(Icons.arrow_upward,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                    const SizedBox(
                      width: 20,
                    ),
                    FadeInLeft(
                        child: _sendReceive(context,
                            title: 'Approve',
                            icon: Icon(Icons.done,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                    const SizedBox(
                      width: 20,
                    ),
                    FadeInLeft(
                        child: _sendReceive(context,
                            title: 'Cancel',
                            icon: Icon(Icons.clear,
                                size: 30, color: Colors.grey[400]),
                            balance: account_balance,
                            address: widget.address,
                            name: widget.name)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _viewAll(title: 'Messages'),
                ),
                LiveList(
                  showItemInterval: const Duration(milliseconds: 100),
                  showItemDuration: const Duration(seconds: 1),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _currency.length,
                  itemBuilder: _buildAnimatedItem,
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: AssetsCard(
              title: _currency[index]['name'] +
                  ' ' +
                  '(' +
                  _currency[index]["symbol"] +
                  ')',
              price: _currency[index]['symbol'],
              logo: _currency[index]['logo'],
              chart: 'chart',
              rise: '\$5,017',
              percent: '3.75%',
            ),
          ),
        ),
      );

  _sendReceive(BuildContext context,
      {required Icon icon,
      required String title,
      required double balance,
      required String address,
      required String name}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            switch (title) {
              case 'Receive':
                {
                  _showWalletAddress();
                }
                break;
              case 'Send':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Transfer(
                        address: address,
                        name: name,
                        accountCtx: context,
                      ),
                    ),
                  );
                }
                break;
              case 'Sign':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageResultPage(
                        name: name,
                        address: address,
                        messageCid:
                            'bafy2bzacebhhjdnnwxnm4ikpf7j7fc23vd5vud6fcnyopoartujnlpxtvanly',
                      ),
                    ),
                  );
                }
                break;
              case 'Create':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateMultisig(
                        address: address,
                        name: name,
                      ),
                    ),
                  );
                }
                break;
              case 'MultiSend':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultisigSend(
                        address: address,
                        name: name,
                      ),
                    ),
                  );
                }
                break;
              case 'Approve':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultisigApprove(
                        address: address,
                        name: name,
                      ),
                    ),
                  );
                }
                break;
              case 'Cancel':
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultisigCancel(
                        address: address,
                        name: name,
                      ),
                    ),
                  );
                }
                break;
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.17,
            height: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: icon,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[300], fontSize: 15),
        )
      ],
    );
  }

  _viewAll({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.grey[300],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class BalanceWidget extends StatefulWidget {
  final String address;
  const BalanceWidget({required this.address});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  double account_balance = 0;
  final _isRunning = true;

  Future<void> _callGetBalance(String address) async {
    final data = await getBalance(address);
    if (mounted) setState(() => account_balance = data);
  }

  @override
  void initState() {
    super.initState();
    _callGetBalance(widget.address);
    Timer.periodic(const Duration(seconds: 5 * 60), (Timer timer) {
      if (!_isRunning) {
        // cancel the timer
        timer.cancel();
      }
      _callGetBalance(widget.address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(account_balance.toStringAsFixed(4),
        style: const TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.w500));
  }
}
