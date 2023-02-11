import 'package:hive/hive.dart';

const dbName = "keyBox";
Future<void> db_insert(dynamic key, dynamic value) async {
  final encryptedBox = await Hive.openBox(
    dbName,
  );
  encryptedBox.put(key, value);
  return;
}

Future<dynamic> db_get(dynamic key) async {
  final encryptedBox = await Hive.openBox(
    dbName,
  );

  return encryptedBox.get(key);
}
