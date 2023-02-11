import 'dart:convert';

import 'package:f3_wallet/ffi.io.dart';
import 'package:f3_wallet/services/lotus.dart';
import 'package:f3_wallet/services/lotus_gas.dart';
import 'package:f3_wallet/services/lotus_nonce.dart';
import 'package:tuple/tuple.dart';

Future<Tuple2<Map<String, Object?>, String>> createMsigCancelMessage(
// Future<String> createMsigSendMessage(
    String multisig,
    int id,
    String from,
    {int? nonce,
    int? gasLimit,
    String? gasFeeCap,
    String? gasPremium}) async {
  final params = await api.multisigApproveParams(txnid: id);

  final msg = await createMessageWithCid(from, multisig,
      nonce: nonce,
      params: params,
      method: 4,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium);

  return msg;
}

Future<Tuple2<Map<String, Object?>, String>> createMsigApproveMessage(
// Future<String> createMsigSendMessage(
    String multisig,
    int id,
    String from,
    {int? nonce,
    int? gasLimit,
    String? gasFeeCap,
    String? gasPremium}) async {
  final params = await api.multisigApproveParams(txnid: id);

  final msg = await createMessageWithCid(from, multisig,
      nonce: nonce,
      params: params,
      method: 3,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium);

  return msg;
}

Future<Tuple2<Map<String, Object?>, String>> createMsigSendMessage(
// Future<String> createMsigSendMessage(
    String sender,
    String to,
    String value,
    String from,
    {int? nonce,
    int? gasLimit,
    String? gasFeeCap,
    String? gasPremium}) async {
  final createParams =
      await api.multisigSendProposeParams(to: to, value: value);

  final msg = await createMessageWithCid(from, sender,
      nonce: nonce,
      params: createParams,
      method: 2,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium);

  return msg;
}

Map<String, Object?> createMessageRaw(String from, String to,
    {int? nonce,
    String? value,
    int? gasLimit,
    int? method,
    String? gasFeeCap,
    String? gasPremium,
    String? params}) {
  var msgRaw = {
    "Version": 0,
    "To": to,
    "From": from,
    "Nonce": nonce ?? 0,
    "Value": value ?? "0",
    "GasLimit": gasLimit ?? 0,
    "GasFeeCap": gasFeeCap ?? "0",
    "GasPremium": gasPremium ?? "0",
    "Method": method ?? 0,
    "Params": params,
  };

  return msgRaw;
}

Future<Tuple2<Map<String, Object?>, String>> createMessageWithCid(
    String from, String to,
    {int? nonce,
    String? value,
    int? method,
    int? gasLimit,
    String? gasFeeCap,
    String? gasPremium,
    String? params}) async {
  final nonceout = await getNonce(from, nonce: nonce);

  var msgRaw = createMessageRaw(from, to,
      value: value,
      nonce: nonceout,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium,
      method: method,
      params: params);

  final res_msg_cid = await getMessageWithCid(msgRaw);
  final res_msg = res_msg_cid.item1;
  final res_cid = res_msg_cid.item2;

  print("------------------------------------");
  print(res_msg);
  print("------------------------------------");
  print('from: ' + from);
  print('to: ' + to);
  print('nonceout:' + nonceout.toString());
  print('value: ' + (value ?? ""));
  print('method:' + method.toString());
  print('params: ' + params.toString());
  print('GasLimit: ' + res_msg["GasLimit"].toString());
  print('GasFeeCap: ' + res_msg["GasFeeCap"].toString());
  print('GasPremium: ' + res_msg["GasPremium"].toString());
  print("------------------------------------");

  final cid = await api.messageCid(
      from: from,
      to: to,
      nonce: nonceout,
      value: value ?? "0",
      method: method ?? 0,
      params: params ?? "",
      gasLimit: int.parse(res_msg["GasLimit"].toString()),
      gasFeeCap: res_msg["GasFeeCap"].toString(),
      gasPremium: res_msg["GasPremium"].toString());

  print("------------------------------------");
  print(cid);
  print(res_cid);
  print("------------------------------------");
  return Tuple2(res_msg, cid);
}

Future<Tuple2<Map<String, Object?>, String>> createMsigCreateMessage(
    String from, List<String> singers, int threshold,
    {int? nonce,
    int? gasLimit,
    String? value,
    String? gasFeeCap,
    String? gasPremium}) async {
  final createParams = await api.createMultisigParams(
      addresses: singers,
      threshold: threshold,
      unlockDuration: 0,
      startEpoch: 0);

  final msg = await createMessageWithCid(from, "t01",
      value: value,
      nonce: nonce,
      params: createParams,
      method: 2,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium);

  return msg;
}

Future<Tuple2<Map<String, Object?>, String>> getMessageWithCid(
    Map<String, Object?> msg) async {
  final response = await lotusRpcRequest(
    "Filecoin.GasEstimateMessageGas",
    [
      msg,
      {"MaxFee": "0"},
      []
    ],
  );
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++");
  print(response);
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++");

  final cid = response['result']['CID']['/'];

  return Tuple2(response['result'], cid);
}

Future<Tuple2<Map<String, Object?>, String>> createSendMessageWithCid(
    String from, String to, String value,
    {int? nonce, int? gasLimit, String? gasFeeCap, String? gasPremium}) async {
  final msg = await createMessageWithCid(from, to,
      value: value,
      nonce: nonce,
      gasFeeCap: gasFeeCap,
      gasLimit: gasLimit,
      gasPremium: gasPremium);

  return msg;
}

Future<String> sendSignedMessage(
    Map<String, Object?> msg, String sigType, String sig, String cid) async {
  final sigTypeInt = int.parse(sigType);

  final response = await lotusRpcRequestWrite(
    "Filecoin.MpoolPushUntrusted",
    [
      {
        "Message": msg,
        "Signature": {"Type": sigTypeInt, "Data": sig},
        "CID": {"/": cid}
      }
    ],
  );

  print(response);

  return response["result"]["/"];
}
