import 'dart:async';

import 'dart:convert';
import 'package:admin_tools/admin_tools.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../mock/startup.dart';

Future main() async {
  TestApplication app = new TestApplication();
  setUpAll(() async {
    await app.start(3528);
    Query<RepoVersion> query = new Query<RepoVersion>();
    if (query.entity == null) throw "entity is null";
    query
      ..values.author = (new User()..id = 1)
      ..values.branchName = "initial"
      ..values.repo = ""
      ..values.created = new DateTime.now()
      ..values.name = "initial_test_repo";
    return query.insert();
  });

  tearDownAll(() async {
    try {
      await app.stop();
    } catch (e) {
      print("$e");
    }
  });
  group("Get repo - Success", () {
    test("Get repo without any branch should return initial repo", () async {
      var req = app.client.authenticatedRequest("/api/repo/");
      var result = await req.get();

      expect(result, hasResponse(200, partial({"id": greaterThan(0)})));
    });
  });
  group("Save repo - Success", () {
    test("Save repo with branchName", () async {
      var req = app.client.authenticatedRequest("/api/repo/");
      Map body = {
        "name": "name of test repo",
        "branchName": "test_branch",
        "basedOnId": 1,
        "repo": JSON.encode({"tags": [], "relations": []})
      };
      req.body = JSON.encode(body);
      var result = await req.post();

      expect(
          result,
          hasResponse(
              200, partial({"id": greaterThan(1), "branchName": equals(body["branchName"]), "repo": equals(body["repo"])})));
    });
  });
}
