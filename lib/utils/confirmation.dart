import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/widget/verify_password.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

List<Widget> _getItems(
  Map<String, String> content,
) {
  List<Widget> out = [];
  content.forEach((key, value) {
    out.add(Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    key,
                    // textBaseline: TextBaseline.alphabetic,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )),
              ),
              Expanded(
                flex: 16,
                child: Container(
                  child: Text(
                    value,
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
      ],
    ));
  });

  return out;
}

void showConfirmationDialog(
    String address,
    String name,
    String? title,
    Tuple2<Map<String, Object?>, String> msg,
    Map<String, String> content,
    BuildContext context) {
  // void _showConfirmationDialog() {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: blueMain,
        appBar: AppBar(
          title: const Text("Confirmation Details"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: blueMain,
        ),
        body: Container(
          height: 1000,
          child: Column(
            children: [
              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        title,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 8),
              ..._getItems(content)
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
              _showVerifyPasswordDialog(name, address, msg, context);
            },
            child: const Text(
              'Confirm',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    },
  );
}

void _showVerifyPasswordDialog(String name, String address,
    Tuple2<Map<String, Object?>, String> msg, BuildContext context) {
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
