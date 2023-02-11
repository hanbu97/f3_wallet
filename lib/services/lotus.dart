import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> lotusRpcRequestWrite(
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

  // Send the POST request
  var response = await http.post(
    Uri.parse('http://113.107.237.201:4234/rpc/v0'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBbGxvdyI6WyJyZWFkIiwid3JpdGUiLCJzaWduIiwiYWRtaW4iXX0.qcLbtzvfSoMbfC9BcX08RvSUHzUvi7VvpCLO2OY7ihA'
    },
    body: json.encode(jsonRpcParams),
  );

  // Return the parsed JSON response
  return json.decode(response.body);
  // return response.body.toString();
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

  // Send the POST request
  var response = await http.post(
    Uri.parse('http://113.107.237.201:4234/rpc/v0'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(jsonRpcParams),
  );

  // Return the parsed JSON response
  return json.decode(response.body);
  // return response.body.toString();
}

Future<double> getBalance(String address) async {
  final receivedText =
      await lotusRpcRequest("Filecoin.WalletBalance", [address]);

  final value = BigInt.parse(receivedText["result"]).toDouble() / 1e18;

  return value;
}
