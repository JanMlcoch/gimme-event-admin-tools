import 'dart:async';

import 'package:admin_tools/model/library.dart';
import 'package:test/test.dart';
import 'package:aqueduct/aqueduct.dart';
import '../mock/startup.dart';

Future main() async {
  TestApplication app = new TestApplication();
  setUpAll(() async {
    await app.start(3528);
//    throw ManagedContext.defaultContext.dataModel;
//    Query<RepoVersion> query = new Query<RepoVersion>();
//    if(query.entity==null) throw "entity is null";
//    query
//      ..values.author = (new User()..id = 1)
//      ..values.branchName = "initial"
//      ..values.created = new DateTime.now()
//      ..values.name = "initial_test_repo";
//    return query.insert();
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
      await ManagedContext.defaultContext.persistentStore.execute(
          "INSERT INTO _RepoVersion (name,repo,created,branchName) VALUES (@name,@repo,@created,@branchName);",
          substitutionValues: {
            "name": "initial root of all repos",
            "repo": '{"tags":[],"relations":[]}',
            "created": new DateTime.now(),
            "branchName": "initial"
          });
      Query<RepoVersion> query = new Query<RepoVersion>();
      throw (await query.fetch()).length;
      var req = app.client.authenticatedRequest("/api/repo/");
      var result = await req.get();

      expect(result, hasResponse(200, partial({"id": greaterThan(0)})));
    });
  });
}
