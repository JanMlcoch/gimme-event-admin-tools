import 'dart:async';

import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../mock/startup.dart';

Future main() async {
  group("Success cases", () {
    TestApplication app = new TestApplication();

    setUpAll(() async {
      await app.start(3566);
    });

    tearDownAll(() async {
      try {
        await app.stop();
      } catch (e) {
        print("$e");
      }
    });

    test("Identity returns user with valid token", () async {
      var req = app.client.authenticatedRequest("/api/identity");
      var result = await req.get();

      expect(result, hasResponse(200, partial({
        "id": greaterThan(0),
        "username":"test_user"
      })));
    });
  });
}
