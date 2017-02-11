import 'dart:async';

import 'dart:convert';
import 'package:admin_tools/admin_tools.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../../mock/startup.dart';

Future main() async {
  TestApplication app = new TestApplication();
  setUpAll(() async {
    await app.start(3527);

    Map<String, List<Map<String, dynamic>>> repo = {
      "tags": [
        {"id": 1, "name": "pivo", "type": "core"},
        {"id": 2, "name": "les", "type": "copmosite"},
        {"id": 3, "name": "larp", "type": "comparable"}
      ],
      "relations": []
    };

    Query<RepoVersion> query = new Query<RepoVersion>();
    query
      ..values.author = (new User()..id = 1)
      ..values.branchName = "initial"
      ..values.repo = JSON.encode(repo)
      ..values.created = new DateTime.now()
      ..values.name = "initial_test_repo";
    await query.insert();
  });

  tearDownAll(() async {
    try {
      await app.stop();
    } catch (e) {
      print("$e");
    }
  });
  test("Get all tags - success", () async {
    var req = app.client.authenticatedRequest("/api/tags");
    var result = await req.get();

    expect(
        result,
        hasResponse(
            200,
            equals([
              {"id": 1, "name": "pivo"},
              {"id": 2, "name": "les"},
              {"id": 3, "name": "larp"}
            ])));
  });
  test("Get all tags - fail", () async {
    var req = app.client.authenticatedRequest("/api/tags/");
    var result = await req.get();

    expect(result.statusCode,501); // NOT IMPLEMENTED
  });
}
