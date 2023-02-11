import 'dart:convert';
import 'dart:ffi';

import 'package:f3_wallet/services/lotus.dart';
import 'package:tuple/tuple.dart';

Future<int> getGasLimit(Map<String, dynamic> msg, {int? gasLimit}) async {
  if (gasLimit != null) {
    return gasLimit;
  }

  final value = await lotusRpcRequest(
    "Filecoin.GasEstimateGasLimit",
    [msg, []],
  );

  return value['result'];
}

Future<String> getFeeCap(Map<String, dynamic> msg, {String? gasFeeCap}) async {
  if (gasFeeCap != null) {
    return gasFeeCap;
  }

  final value = await lotusRpcRequest(
    "Filecoin.GasEstimateFeeCap",
    [msg, 9, []],
  );

  return value['result'];
}

Future<String> getGasPremium(String sender, int gasLimit,
    {String? gasPremium}) async {
  if (gasPremium != null) {
    return gasPremium;
  }

  final value = await lotusRpcRequest(
    "Filecoin.GasEstimateGasPremium",
    [3, sender, gasLimit, []],
  );

  return value['result'];
}

Future<Tuple3<int, String, String>> getGas(
    Map<String, dynamic> msg, String address,
    {int? gasLimit, String? gasFeeCap, String? gasPremium}) async {
  var gasList = [0, "", ""];
  var gaslimit = 0;

  await Future.wait([
    getGasLimit(msg, gasLimit: gasLimit).then((value) async {
      gaslimit = value;
      gasList[2] = await getGasPremium(address, value, gasPremium: gasPremium);
    }),
    getFeeCap(msg, gasFeeCap: gasFeeCap).then((value) {
      gasList[1] = value;
    }),
  ]);

  // more gas
  if (gasLimit == null) {
    gasList[0] = gaslimit + 100000;
  } else {
    gasList[0] = gaslimit;
  }

  if (gasPremium == null) {
    gasList[2] =
        (BigInt.parse(gasList[2].toString()) + BigInt.from(10000)).toString();
  }

  if (gasFeeCap == null) {
    gasList[1] = (BigInt.parse(gasList[2].toString()) +
            BigInt.parse(gasList[1].toString()) +
            BigInt.from(10800))
        .toString();
  }

  return Tuple3<int, String, String>.fromList(gasList);
}
