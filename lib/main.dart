import 'package:f3_wallet/screen/home_view.dart';
import 'package:flutter/material.dart' hide Size;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'ffi/ffi.io.dart' if (dart.library.html) 'ffi.web.dart';
export 'ffi/ffi.io.dart' if (dart.library.html) 'ffi.web.dart' show api;

void main() async {
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F3 Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'F3 Wallet',
      ),
      // home: const Scaffold(),
    );
  }
}
