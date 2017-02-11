library common.requests;

import 'dart:html';
import 'dart:async';
import 'dart:math' as math;
import 'dart:convert';

class Gateway {
  static String accessToken;
  static String dataFromResponse;
  static DateTime lastLogin;
}

Future<String> login() async {
  if (Gateway.accessToken != null &&
      new DateTime.now().difference(Gateway.lastLogin).inMilliseconds > const Duration(minutes: 20).inMilliseconds) {
    return Gateway.dataFromResponse;
  }

  Gateway.lastLogin = new DateTime.now();
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
    Map tokens = JSON.decode(dataFromResponse);
    String token = tokens["access_token"];
    Gateway.accessToken = token;
    Gateway.dataFromResponse = dataFromResponse;
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


Future logout(String token) async {
  Completer completer = new Completer();
  HttpRequest.request(
      "http://localhost:8000/api/auth/logout", method: "POST" /*, sendData: jsonString*/, requestHeaders: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json;charset=UTF-8"
  }).then((HttpRequest resp) {
    completer.complete();
  });
  await completer.future;
}
