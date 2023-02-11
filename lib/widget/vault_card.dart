import 'package:f3_wallet/model/storage_item.dart';
import 'package:f3_wallet/screen/account_page.dart';
import 'package:f3_wallet/utils/secure_storeage.dart';
import 'package:f3_wallet/shared/app_colors.dart';
import 'package:flutter/material.dart';
// import 'package:secure_storage/models/storage_item.dart';
// import 'package:secure_storage/services/storage_service.dart';
// import 'package:secure_storage/widgets/edit_data_dialog.dart';

class VaultCard extends StatefulWidget {
  StorageItem item;

  VaultCard({required this.item, Key? key}) : super(key: key);

  @override
  State<VaultCard> createState() => _VaultCardState();
}

class _VaultCardState extends State<VaultCard> {
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [yellowStart, yellowEnd],
            ),
          ),
          child: ListTile(
            title: Text(
              widget.item.key,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              widget.item.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(
                    address: widget.item.value,
                    name: widget.item.key,
                  ),
                ),
              );
            },
            leading: const Icon(Icons.security, size: 30),
          )),
    );
  }
}
