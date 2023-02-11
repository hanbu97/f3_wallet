import 'dart:convert';

import 'package:hive/hive.dart';

const dbName = "keyBoxEncrypted";
List<int> dbKey = [];

Future<void> dbInsert(dynamic key, dynamic value) async {
  if (dbKey.isEmpty) {
    dbKey = Hive.generateSecureKey();
    print(base64UrlEncode(key));
  }
  final encryptedBox =
      await Hive.openBox(dbName, encryptionCipher: HiveAesCipher(dbKey));
  encryptedBox.put(key, value);
  return;
}

Future<dynamic> dbGet(dynamic key) async {
  if (dbKey.isEmpty) {
    dbKey = Hive.generateSecureKey();
    print(base64UrlEncode(key));
  }
  final encryptedBox =
      await Hive.openBox(dbName, encryptionCipher: HiveAesCipher(dbKey));

  return encryptedBox.get(key);
}
