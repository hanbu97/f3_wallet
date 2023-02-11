import 'package:f3_wallet/services/lotus.dart';

Future<Map<String, Object?>?> stateWaitMsg(String msgcid) async {
  final receivedText = await lotusRpcRequest("Filecoin.StateWaitMsg", [
    {"/": msgcid},
    0
  ]);

  final value = receivedText["result"]["ReturnDec"];
  return value;
}
