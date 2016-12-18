import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../mock/startup.dart';

void main() {
  group("Success cases", () {
    TestApplication app = new TestApplication();

    setUpAll(() {
      return app.start(3567);
    });

    tearDownAll(() {
      return app.stop();
    });

    test("Can create user", () async {
      TestRequest request = app.client.authenticatedRequest("/api/auth/register")
        ..json = {"username":"bob","email": "bob@stablekernel.com", "password": "foobaraxegrind12%"};
      var response = await request.post();

      expect(response, hasResponse(200, partial({
        "id": greaterThan(0)
      })));
    });
  });

  group("Failure cases", () {
    TestApplication app = new TestApplication();

    setUpAll(() async {
      await app.start(3564);
    });

    tearDownAll(() async {
      await app.stop();
    });
    test("Trying to create existing user fails", () async {
      var response = await (app.client.authenticatedRequest("/api/auth/register")
        ..json = {"username":"bob","email": "bob@stablekernel.com", "password": "someotherpassword"}).post();

      expect(response, hasStatus(200));
      var secondResponse = await (app.client.authenticatedRequest("/api/auth/register")
        ..json = {"username":"bob","email": "bob@stablekernel.com", "password": "foobaraxegrind12%"}).post();

      expect(secondResponse, hasStatus(409));
    });

    test("Omit password fails", () async {
      var response = await (app.client.authenticatedRequest("/api/auth/register")
        ..json = {"username":"bob","email": "bobby.bones@stablekernel.com"}).post();

      expect(response, hasStatus(400));
    });
    test("Omit email fails", () async {
      var response = await (app.client.authenticatedRequest("/api/auth/register")
        ..json = {"username":"bob","password": "foobaraxegrind12%"}).post();

      expect(response, hasStatus(400));
    });

    test("Omit username fails", () async {
      var response = await (app.client.authenticatedRequest("/api/auth/register")
        ..json = {"email": "bobby.bones@stablekernel.com","password": "foobaraxegrind12%"}).post();

      expect(response, hasStatus(400));
    });
  });
}
