import 'dart:async';
import 'dart:typed_data';

import 'package:f3_wallet/screen/home_view.dart';
import 'package:flutter/material.dart' hide Size;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'ffi/ffi.io.dart' if (dart.library.html) 'ffi.web.dart';
export 'ffi/ffi.io.dart' if (dart.library.html) 'ffi.web.dart' show api;

// Simple Flutter code. If you are not familiar with Flutter, this may sounds a bit long. But indeed
// it is quite trivial and Flutter is just like that. Please refer to Flutter's tutorial to learn Flutter.

// void main() => runApp(const MyApp());
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


// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Uint8List? exampleImage;
//   String? exampleText;

//   @override
//   void initState() {
//     super.initState();
//     runPeriodically(_callExampleFfiOne);
//     _callExampleFfiTwo();
//   }

//   @override
//   Widget build(BuildContext context) => buildPageUi(
//         exampleImage,
//         exampleText,
//       );

//   Future<void> _callExampleFfiOne() async {
//     final receivedImage = await api.drawMandelbrot(
//         imageSize: Size(width: 50, height: 50),
//         zoomPoint: examplePoint,
//         scale: generateScale(),
//         numThreads: 4);
//     if (mounted) setState(() => exampleImage = receivedImage);
//   }

//   Future<void> _callExampleFfiTwo() async {
//     final receivedText = await api.generateAddressFromPrivateKey(
//         input:
//             '7b2254797065223a22626c73222c22507269766174654b6579223a226b434b523969566b73615a6672746b513979356e3269615862317279766d314d37637357456352313142673d227d');
//     if (mounted) setState(() => exampleText = receivedText);
//   }
// }
