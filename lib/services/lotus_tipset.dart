import 'lotus.dart';

class ResponseData {
  List<Cid> cids;

  ResponseData({required this.cids});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    List<Cid> cids = (json['result']['Cids'] as List)
        .map((cid) => Cid.fromJson(cid))
        .toList();
    return ResponseData(
      cids: cids,
    );
  }

  List<String> toList() {
    return cids.map((cid) => cid.cid).toList();
  }
}

class Cid {
  String cid;

  Cid({required this.cid});

  factory Cid.fromJson(Map<String, dynamic> json) {
    return Cid(
      cid: json['/'],
    );
  }
}

Future<String> getTipset() async {
  final responseData = await lotusRpcRequest("Filecoin.ChainHead", []);

  try {
    ResponseData data = ResponseData.fromJson(responseData);
    List<String> cidsString = data.toList();
    // List<Cid> cids = data.cids;
    print(cidsString);

    return cidsString.toString();

    // Use cids here
  } catch (e) {
    print(e);
  }

  return '';
}

Future<String> getTipsetFirst() async {
  final responseData = await lotusRpcRequest("Filecoin.ChainHead", []);

  try {
    ResponseData data = ResponseData.fromJson(responseData);
    List<String> cidsString = data.toList();

    return cidsString.first;

    // Use cids here
  } catch (e) {
    print(e);
  }

  return '';
}
