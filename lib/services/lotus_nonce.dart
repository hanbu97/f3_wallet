import 'package:f3_wallet/services/lotus.dart';

Future<int> getNonce(String address, {int? nonce}) async {
  if (nonce != null) {
    return nonce;
  }

  final receivedText =
      await lotusRpcRequest("Filecoin.MpoolGetNonce", [address]);

  return receivedText["result"];
}
