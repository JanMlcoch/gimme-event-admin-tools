import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration3 extends Migration {
  @override
  Future upgrade() async {
    database.commands = [";"];
  }

  @override
  Future downgrade() async {}
  @override
  Future seed() async {
    String repo = '{"tags":[],"relations":[]}';
    return store.execute(
        "INSERT INTO _RepoVersion (name,repo,created,branchName) VALUES (@name,@repo,@created,@branchName);",
        substitutionValues: {
          "name": "initial root of all repos",
          "repo": repo,
          "created": new DateTime.now(),
          "branchName": "initial"
        });
  }
}
