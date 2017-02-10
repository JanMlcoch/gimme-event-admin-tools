import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration4 extends Migration {
  @override
  Future upgrade() async {
    database.alterColumn("_repoversion", "branchname", (SchemaColumn column) {
      column.defaultValue = "initial";
    });
  }
  @override
  Future downgrade() async {}
  @override
  Future seed() async {}
}
