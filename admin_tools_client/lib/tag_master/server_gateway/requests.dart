library tag_master2.requests;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:math' as math;
import 'package:admin_tools/tag_master/repo/library.dart';
import 'package:admin_tools/common/server_gateway/requests.dart';

Future<int> getRemoteLastRepoId() async {
  String response = await login();
  Map tokens = JSON.decode(response);
  String token = tokens["access_token"];
  dynamic resp = await downloadRepo(token);
  resp = JSON.decode(resp);
  return resp["id"];
}

Future<Map<String, dynamic>> getRepo() async {
  String response = await login();
  Map tokens = JSON.decode(response);
  String token = tokens["access_token"];
  dynamic resp = await downloadRepo(token);
  resp = JSON.decode(resp);
  TagMasterRepository repo = new TagMasterRepository()
    ..fromMap(JSON.decode(resp["repo"]));
  int repoId = resp["id"];
  return {"repo": repo, "repoId": repoId};
}

Future pushRepo(TagMasterRepository repo, int basedOnId) async {
  String response = await login();
  Map tokens = JSON.decode(response);
  await tokens;
  String token = tokens["access_token"];
  await uploadRepo(token, repo, basedOnId);
}

Future downloadRepo(String token) async {
  dynamic response;
  Completer completer = new Completer();
  HttpRequest.request("http://localhost:8000/api/repo/", method: "GET", requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    response = resp.response;
    completer.complete();
  });
  await completer.future;
  return response;
}

Future uploadRepo(String token, TagMasterRepository repo, int basedOnId) async {
  Completer completer = new Completer();
  Map<String, dynamic> repoMap = repo.toMap();
  String repoJson = JSON.encode(repoMap);
  Map<String, dynamic> dataMap = {
    "basedOnId": basedOnId,
    "repo": repoJson,
    "branchName": "devel",
    "name": "time${new DateTime.now().millisecondsSinceEpoch}"
  };
  String dataJson = JSON.encode(dataMap);
  HttpRequest.request("http://localhost:8000/api/repo/", sendData: dataJson, method: "POST", requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    completer.complete();
  });
  await completer.future;
}