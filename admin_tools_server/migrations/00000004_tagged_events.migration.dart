import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration4 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(new SchemaTable("_TaggedEvent", [
      new SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("eventJson", ManagedPropertyType.string,
          isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: true),
      new SchemaColumn("tagsJson", ManagedPropertyType.string,
          isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("created", ManagedPropertyType.datetime,
          isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("updated", ManagedPropertyType.datetime,
          isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("userId", ManagedPropertyType.integer,
          isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
    ]));
  }

  @override
  Future downgrade() async {}
  @override
  Future seed() async {}
}
