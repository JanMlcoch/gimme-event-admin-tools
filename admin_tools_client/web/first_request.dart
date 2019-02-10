import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'dart:math' as math;
import 'package:admin_tools/tag_master/repo/library.dart';
import 'package:admin_tools/tag_master/repo_refactor/new_deserialized.dart';
//import 'package:http/http.dart' as http;

TagMasterRepository sampleRepo = new TagMasterRepository()..fromMap(a);

Future main() async {
  String response = await login();
  Map tokens = JSON.decode(response);
  await tokens;
  String token = tokens["access_token"];
  await register(token);
  dynamic resp = await downloadRepo(token);
  resp = JSON.decode(resp);
  print(resp);
  print(resp["repo"].toString());
  int repoId = resp["id"];
  await uploadRepo(token, sampleRepo, repoId);
  await downloadRepo(token);
  await logout(token);
  await register(token);
}

Future<String> login() async {
  String password = "heslo Admin Tools pro Akcnik webovou aplikaci";
  String clientID = "Akcnik Admin tools";

  String pColonC = "$clientID:$password";
  String b64 = BASE64.encode(UTF8.encode(pColonC));

  Map<String, String> dataToSend = {"grant_type": "password", "username": "admin", "password": "velmi_slozite_heslo"};
  String dataFromResponse;

  await HttpRequest.postFormData(
    "http://localhost:8000/api/auth/login",
    dataToSend,
    requestHeaders: {"Authorization": "Basic $b64"},
  ).then((HttpRequest resp) {
    dataFromResponse = resp.response;
  });
  return await dataFromResponse;
}

Future register(String token) async {
  Map map = {
    "username": "John${(new math.Random(new DateTime.now().millisecondsSinceEpoch)).nextInt(1000000)}",
    "email": "john${(new math.Random(new DateTime.now().millisecondsSinceEpoch)).nextInt(1000000)}@stablekernel.com",
    "password": "d5s4d6f5s6d5f54d5s6df5d4f6sd5f4d6s58f7s6d85f46s5d4f6sd85f84sd65f4"
  };
  Completer completer = new Completer();
  String jsonString = JSON.encode(map);
  HttpRequest.request("http://localhost:8000/api/auth/register", method: "POST", sendData: jsonString, requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    completer.complete();
  });
  await completer.future;
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
    print(resp.response);
    completer.complete();
  });
  await completer.future;
}

Future logout(String token) async {
  Completer completer = new Completer();
  HttpRequest.request("http://localhost:8000/api/auth/logout", method: "POST"/*, sendData: jsonString*/, requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    completer.complete();
  });
  await completer.future;
}
