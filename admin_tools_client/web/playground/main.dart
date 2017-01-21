import 'dart:convert';
import 'dart:html';

void main() {
  String clientId = "Akcnik Admin tools";
  String basicAuth = "Basic ${BASE64.encode("$clientId:heslo Admin Tools pro Akcnik webovou aplikaci".codeUnits)}";
  String accessToken;
  String refreshToken;
  querySelector("#register_me").onClick.listen((_) async {
//    HttpRequest request =
    await HttpRequest.request("/api/auth/register",
        method: "POST",
        requestHeaders: {"authorization": "Bearer $accessToken", "Content-Type": "application/json;charset=UTF-8"},
        sendData: JSON.encode({"username": "second_me","email":"cosicosi@akcnik.cz", "password": "aaa"}));
//    Map<String, dynamic> body = JSON.decode(request.responseText) as Map<String, dynamic>;
//    accessToken = body["access_token"];
//    refreshToken = body["refresh_token"];
  });
  querySelector("#login_me").onClick.listen((_) async {
    HttpRequest request = await HttpRequest.postFormData(
        "/api/auth/login", {"username": "me", "password": "aaa", "grant_type": "password"},
        requestHeaders: {"authorization": basicAuth});
    Map<String, dynamic> body = JSON.decode(request.responseText) as Map<String, dynamic>;
    accessToken = body["access_token"];
    refreshToken = body["refresh_token"];
  });
  querySelector("#logout_me").onClick.listen((_) async {
//    HttpRequest request =
    await HttpRequest.request("/api/auth/logout",
        method: "POST",
        requestHeaders: {"authorization": "Bearer $accessToken", "Content-Type": "application/json;charset=UTF-8"},
        sendData: {});
  });
  querySelector("#refresh_token").onClick.listen((_) async {
    HttpRequest request = await HttpRequest.postFormData(
        "/api/auth/login", {"username": "me", "refresh_token": refreshToken, "grant_type": "refresh_token"},
        requestHeaders: {"authorization": basicAuth});
    Map<String, dynamic> body = JSON.decode(request.responseText) as Map<String, dynamic>;
    accessToken = body["access_token"];
    refreshToken = body["refresh_token"];
  });
  querySelector("#identify_me").onClick.listen((_) async {
//    HttpRequest request =
    await HttpRequest.request("/api/identify",
        method: "GET", requestHeaders: {"authorization": "Bearer $accessToken"}, sendData: {});
  });
//  querySelector("#code_me").onClick.listen((_) async {
//    HttpRequest request = await HttpRequest.postFormData(
//        "/api/auth/code", {"client_id": clientId, "username": "me", "password": "aaa", "grant_type": "password"},
//        requestHeaders: {"authorization": basicAuth});
//    Map<String, dynamic> body = JSON.decode(request.responseText) as Map<String, dynamic>;
//    accessToken = body["access_token"];
//    refreshToken = body["refresh_token"];
//  });
}
