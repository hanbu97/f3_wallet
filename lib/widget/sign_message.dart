import 'package:f3_wallet/widget/sign_message_item.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignMessage extends StatefulWidget {
  const SignMessage({super.key});

  @override
  State<SignMessage> createState() => _SignMessageState();
}

class _SignMessageState extends State<SignMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      child: Container(
        color: Colors.red,
        // child: ListView.builder(
        //   padding: EdgeInsets.only(top: 20.h),
        //   // controller: _scrollController,
        //   itemBuilder: (context, index) {
        //     return const SignMessageItem();
        //   },
        //   itemCount: 1,
        // ),
      ),
    );
  }
}
