import 'package:admin_tools/admin_tools.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../mock/startup.dart';

void main() {
  group("Success cases", () {
    TestApplication app = new TestApplication();
    String username = "tupec";
    String password = "heslo";
    String accessToken;

    setUpAll(() async {
      await app.start(3561);
      var salt = AuthServer.generateRandomSalt();
      var hashedPassword = AuthServer.generatePasswordHash(password, salt);
      Query<User> query = new Query<User>();
      query.values
        ..username = username
        ..hashedPassword = hashedPassword
        ..email = "test_cosi@akcnik.cz"
        ..salt = salt;
      return query.insert();
    });

    tearDownAll(() {
      return app.stop();
    });

    test("Login user", () async {
      TestRequest request = app.client.clientAuthenticatedRequest("/api/auth/login")
        ..formData = {"username": username, "password": password, "grant_type": "password"};
      var response = await request.post();

      expect(response, hasResponse(200, partial({"access_token": isNotNull})));
      accessToken = response.asMap["access_token"];
      expect(accessToken, isNotNull);
    });
    test("Logout user", () async {
      TestRequest request = app.client.authenticatedRequest("/api/auth/logout")..bearerAuthorization = accessToken;
      var response = await request.post();

      expect(response, hasResponse(200, partial({"message": contains("logout")})));
    });
  });
}
