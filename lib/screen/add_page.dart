import 'package:animate_do/animate_do.dart';
import 'package:f3_wallet/ffi/ffi.io.dart';
import 'package:f3_wallet/model/storage_item.dart';
import 'package:f3_wallet/screen/home_view.dart';
import 'package:f3_wallet/utils/secure_storeage.dart';
import 'package:f3_wallet/utils/encryption.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:hive_flutter/adapters.dart';

class IntroPage extends StatefulWidget {
  final bool isAdd;
  const IntroPage({required this.isAdd});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final StorageService _storageService = StorageService();

  bool _loading = true;

  late List<StorageItem> _items;

  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _pkTextController = TextEditingController();
  final _passwdTextController = TextEditingController();
  final _repasswdTextController = TextEditingController();

  var _errorText = '';
  var _isError = false;
  // TextEditingController? _pkTextController;
  // TextEditingController? _passwdTextController;
  // TextEditingController? _repasswdTextController;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameTextController.dispose();
    _pkTextController.dispose();
    _passwdTextController.dispose();
    _repasswdTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() async {
    _items = await _storageService.readAllSecureData();
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: widget.isAdd
          ? AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Container(
          padding: widget.isAdd
              ? const EdgeInsets.only(top: 0, right: 16, left: 16)
              : const EdgeInsets.only(top: 30, right: 16, left: 16),
          child: Column(children: [
            FadeInDown(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/NFT_4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            FadeInLeft(
                child: Text(
              'Import Your Filecoin Wallet',
              style: TextStyle(
                  color: Colors.yellowAccent[700],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            )),
            const SizedBox(
              height: 20,
            ),
            FadeInLeft(
                child: TextField(
              controller: _nameTextController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: 'Tap to input wallet name',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              style: const TextStyle(
                  color: Color.fromARGB(255, 136, 129, 96),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            )),
            FadeInLeft(
                child: TextField(
              controller: _pkTextController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: 'Tap to input private key',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              // autofillHints: [AutofillHints.telephoneNumberLocalSuffix],
              keyboardType: TextInputType.multiline,
              minLines: 3, // <-- SEE HEREu
              maxLines: 3, // <-- SEE HERE
              style: const TextStyle(
                  color: Color.fromARGB(255, 136, 129, 96),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            )),
            // const SizedBox(
            //   height: 20,
            // ),
            FadeInLeft(
                child: TextFormField(
              controller: _passwdTextController,
              textAlign: TextAlign.center,
              obscureText: true,
              validator: passwordValidator,
              decoration: const InputDecoration(
                  hintText: 'Tap to input wallet password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              style: const TextStyle(
                  color: Color.fromARGB(255, 136, 129, 96),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            )),
            FadeInLeft(
                child: TextField(
              obscureText: true,
              controller: _repasswdTextController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: 'Tap to repeat wallet password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  )),
              autofillHints: [AutofillHints.telephoneNumberLocalSuffix],
              keyboardType: TextInputType.multiline,
              minLines: 1, // <-- SEE HEREu
              maxLines: 1, // <-- SEE HERE
              style: const TextStyle(
                  color: Color.fromARGB(255, 136, 129, 96),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
            )),
            Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> _key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    sliderRotate: false,
                    outerColor: Colors.grey[900],
                    innerColor: Colors.yellowAccent[700],
                    child: FadeInRight(
                        child: const Text(
                      'Swipe to get started',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                    key: _key,
                    sliderButtonIcon: const Icon(IconlyBroken.arrow_right),
                    onSubmit: () async {
                      // password not match reject
                      if (_passwdTextController.text.length < 8) {
                        _errorText =
                            'Password should be longer than 8 characters.';
                        _isError = true;
                      } else if (_passwdTextController.text !=
                          _repasswdTextController.text) {
                        _errorText = 'Password not match!';
                        _isError = true;
                      }

                      // if name exists reject
                      var containsKey = await _storageService
                          .containsKeyInSecureData(_nameTextController.text);
                      if (containsKey) {
                        _errorText = 'Name of account already exists!';
                        _isError = true;
                      }

                      final encrypted = encryptFernet(
                          _passwdTextController.text, _pkTextController.text);

                      // key: pk name
                      // value: add time
                      final now = DateTime.now().toString();

                      final private_key = _pkTextController.text;
                      final address = await api.generateAddressFromPrivateKey(
                          input: private_key);

                      final pkName = _nameTextController.text;
                      final StorageItem newItem = StorageItem(pkName, address);

                      await Hive.initFlutter();
                      await db_insert(pkName, encrypted);

                      // to local transparent storage
                      _storageService.writeSecureData(newItem).then((value) {
                        setState(() {
                          _loading = true;
                        });
                        initList();
                      });
                      //  }

                      if (_isError) {
                        showDialog<bool>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Import Error'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(_errorText),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const IntroPage(
                                                  isAdd: false,
                                                )),
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      } else {
                        Future.delayed(
                          const Duration(milliseconds: 500),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                        title: 'F3 Wallet',
                                      )),
                            );
                          },
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must contain atleast 8 characters';
    } else {
      return null;
    }
  }
}
