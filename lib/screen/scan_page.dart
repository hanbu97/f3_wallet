import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  final Function(Barcode? result)? completed;

  const ScanPage({
    Key? key,
    this.completed,
  }) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  @override
  void reassemble() {
    super.reassemble();
    _controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7), //默认颜色，太白了不好看
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: SafeArea(
              child: CupertinoButton(
                onPressed: () {
                  _controller?.toggleFlash();
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 64,
                    // child: Image.asset('images/flash_light.png'),
                    child: Icon(
                      Icons.flash_auto,
                    )),
              ),
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 60,
                height: 44,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((result) {
      //print(result.code);
      _controller!.stopCamera();
      Navigator.of(context).pop();
      if (widget.completed != null) {
        widget.completed!(result);
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}
