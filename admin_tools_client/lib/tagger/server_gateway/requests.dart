import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:admin_tools/common/server_gateway/requests.dart';
import 'package:admin_tools/tagger/model/library.dart';

Future<List> getTags() async {
  String response = await login();
  Map tokens = JSON.decode(response);
  String token = tokens["access_token"];
  dynamic resp = await downloadRepo(token);
  List tagsData = JSON.decode(resp);
//  Tags tags = new Tags()..fromList(resp);
  return tagsData;
}

Future<String> downloadRepo(String token) async {
  dynamic response;
  Completer completer = new Completer();
  HttpRequest.request("http://localhost:8000/api/tags", method: "GET", requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    response = resp.response;
    completer.complete();
  });
  await completer.future;
  return response;
}

Future uploadEvent(Map event) async {
  String response = await login();
  Map tokens = JSON.decode(response);
  String token = tokens["access_token"];
  Completer completer = new Completer();
  Map<String, dynamic> dataMap = event;
  String dataJson = JSON.encode(dataMap);
  HttpRequest.request("http://localhost:8000/api/tagged_events", sendData: dataJson, method: "POST", requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    completer.complete();
  });
  await completer.future;
}

