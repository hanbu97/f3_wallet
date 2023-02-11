import 'package:f3_wallet/ffi/ffi.io.dart';
import 'package:f3_wallet/screen/result_page.dart';
import 'package:f3_wallet/services/lotus_message.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/utils/encryption.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class VerifyPassword extends StatefulWidget {
  final String name;
  final String address;
  final Tuple2<Map<String, Object?>, String> msg;

  const VerifyPassword({
    super.key,
    required this.name,
    required this.address,
    required this.msg,
  });

  @override
  State<VerifyPassword> createState() => _VerifyPasswordState();
}

class _VerifyPasswordState extends State<VerifyPassword> {
  var _isPasswordVisible = false;
  String _pasword = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: blueMain,
      content: Form(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Please enter your wallet password',
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                // 使用一个变量来保存密码是否明文显示的状态
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () {
                // 点击图标时切换密码是否明文显示的状态
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          // 使用一个变量来保存密码是否明文显示的状态
          obscureText: !_isPasswordVisible,
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _pasword = value;
            });
          },
        ),
      ),
      title: const Text(
        'Verify Password',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        ButtonBar(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const VerticalDivider(color: Colors.grey),
            TextButton(
              onPressed: () async {
                var private = await db_get(widget.name);
                final privateKey = decryptFernet(_pasword, private);
                final sig = await api.signMessageWithPrivateKey(
                    msg: widget.msg.item2, privateKey: privateKey);

                final msgcid = await sendSignedMessage(
                    widget.msg.item1, sig[1], sig[0], widget.msg.item2);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageResultPage(
                      address: widget.address,
                      name: widget.name,
                      messageCid: msgcid,
                    ),
                  ),
                );

                // MessageResultPage

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AccountPage(
                //       address: widget.address,
                //       name: widget.name,
                //     ),
                //   ),
                // );
                // print(widget.msg.item1);
                // print(sig[0]);
                // print(sig[1]);
                // final sig = await api.print(decrypted);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text('Cancel'),
        // ),
        // TextButton(
        //   onPressed: () {
        //     // TODO: 确认操作
        //   },
        //   child: Text('Confirm'),
        // ),
      ],
    );
    ;
  }
}
