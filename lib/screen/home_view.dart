import 'package:f3_wallet/shared/app_colors.dart';
import 'package:f3_wallet/widget/vault_card.dart';
import 'package:flutter/material.dart';
import '../model/storage_item.dart';
import '../services/secure_storeage.dart';
import 'package:f3_wallet/screen/add_page.dart';
// import 'package:secure_storage/widgets/add_data_dialog.dart';
// import 'package:secure_storage/widgets/search_key_value_dialog.dart';
// import 'package:secure_storage/widgets/vault_card.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StorageService _storageService = StorageService();
  List<StorageItem> _items = [];
  bool _loading = true;

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
      backgroundColor: blueMain,
      appBar: _items.isEmpty
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: blueMain,
              title: Text(widget.title),
            ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _items.isEmpty
                ? const IntroPage(
                    isAdd: false,
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (_, index) {
                      return Dismissible(
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        // key: Key(_items[index].toString()),
                        key: UniqueKey(),
                        child: VaultCard(item: _items[index]),
                        onDismissed: (direction) async {
                          await _storageService
                              .deleteSecureData(_items[index])
                              .then((value) => _items.removeAt(index));
                          initList();
                        },
                      );
                    }),
      ),
      floatingActionButton: _items.isEmpty
          ? null
          : SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // primary: Colors.black,
                            minimumSize: const Size.fromHeight(50), // NEW
                            backgroundColor: yellowStartWallet),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IntroPage(
                                      isAdd: true,
                                    )),
                          );
                        },
                        child: const Text(
                          'Add Wallet',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
