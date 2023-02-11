import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignMessageItem extends StatelessWidget {
  const SignMessageItem({super.key});

  // const SignMessageItem(
  //     {Key? key, required Coin coin, isPortafolio = false, VoidCallback? onTap})
  //     : _coin = coin,
  //       _onTap = onTap,
  //       _isPortafolio = isPortafolio,
  //       super(key: key);

  // final Coin _coin;
  // final bool _isPortafolio;
  // final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade200,
      ))),
      child: ListTile(
        // onTap: _onTap,
        leading: Image.network(
          'https://www.cryptocompare.com/media/20646/btc.png',
        ),
        title: Text(
          'Bitcoin',
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'BTC',
          style: TextStyle(fontSize: 28.sp),
        ),
        trailing: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$10,000',
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
