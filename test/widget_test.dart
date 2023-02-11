// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:f3_wallet/main.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

//  --data '{
//    "jsonrpc":"2.0",
//    "method":"Filecoin.WalletBalance",
//    "params":[
//       "t3sh7bfopxlxpaxhbrytc54qqwaeuytzlpfy36iuxjknjvm3ycj7ewajbnervggfoqwk4xhjdpvk54bpiesaya"
//    ],
//    "id":7878
//  }' \
// To parse this JSON data, do
//
//     final lotusRpcModel = lotusRpcModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LotusRpcModel lotusRpcModelFromJson(String str) =>
    LotusRpcModel.fromJson(json.decode(str));

String lotusRpcModelToJson(LotusRpcModel data) => json.encode(data.toJson());

class LotusRpcModel {
  LotusRpcModel({
    required this.id,
    required this.jsonrpc,
    required this.method,
    required this.params,
  });

  int id;
  String jsonrpc;
  String method;
  List<String> params;

  factory LotusRpcModel.fromJson(Map<String, dynamic> json) => LotusRpcModel(
        id: json["id"],
        jsonrpc: json["jsonrpc"],
        method: json["method"],
        params: List<String>.from(json["params"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jsonrpc": jsonrpc,
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x)),
      };
}

Future<Map<String, dynamic>> lotusRpcRequest(
    String method, dynamic params) async {
  // Set id to the last five digits of the current time
  int id = DateTime.now().millisecondsSinceEpoch % 100000;

  // Construct the parameters for the JSON-RPC request
  Map<String, dynamic> jsonRpcParams = {
    "jsonrpc": "2.0",
    "method": method,
    "params": params,
    "id": id,
  };

  print(json.encode(jsonRpcParams));

  // Send the POST request
  var response = await http.post(
    Uri.parse('http://113.107.237.201:4234/rpc/v0'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(jsonRpcParams),
  );

  print(response.body);
  print(response.statusCode);

  // Return the parsed JSON response
  // return json.decode(response.body);
  return jsonRpcParams;
}

void main() {
  testWidgets('Test rpc req', (WidgetTester tester) async {
    var response = await lotusRpcRequest("Filecoin.WalletBalance", [
      "t3sh7bfopxlxpaxhbrytc54qqwaeuytzlpfy36iuxjknjvm3ycj7ewajbnervggfoqwk4xhjdpvk54bpiesaya"
    ]);

    print(response);
  });
}
