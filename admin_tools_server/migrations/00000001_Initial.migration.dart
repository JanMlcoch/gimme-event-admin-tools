import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(new SchemaTable("_User", [
      new SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("username", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: true),
      new SchemaColumn("email", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: true),
      new SchemaColumn("hashedPassword", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("salt", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
    ]));

    database.createTable(new SchemaTable("_Client", [
      new SchemaColumn("id", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("hashedPassword", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("salt", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
    ]));

    database.createTable(new SchemaTable("_Token", [
      new SchemaColumn("accessToken", ManagedPropertyType.string, isPrimaryKey: true, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("refreshToken", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),
      new SchemaColumn("issueDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("expirationDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("type", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn.relationship("client", ManagedPropertyType.string, relatedTableName: "_Client", relatedColumnName: "id", rule: ManagedRelationshipDeleteRule.cascade, isNullable: true, isUnique: false),
      new SchemaColumn.relationship("owner", ManagedPropertyType.bigInteger, relatedTableName: "_User", relatedColumnName: "id", rule: ManagedRelationshipDeleteRule.cascade, isNullable: true, isUnique: false),
    ]));

    database.createTable(new SchemaTable("_RepoVersion", [
      new SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("branchName", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("repo", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("basedOnId", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: true, isUnique: false),
      new SchemaColumn("created", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("isGenerated", ManagedPropertyType.boolean, isPrimaryKey: false, autoincrement: false, defaultValue: "FALSE", isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("deployed", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: true, isUnique: false),
      new SchemaColumn.relationship("author", ManagedPropertyType.bigInteger, relatedTableName: "_User", relatedColumnName: "id", rule: ManagedRelationshipDeleteRule.cascade, isNullable: true, isUnique: false),
    ]));

    database.createTable(new SchemaTable("_AuthCode", [
      new SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("code", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: true, isNullable: false, isUnique: false),
      new SchemaColumn("redirectURI", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: true, isUnique: false),
      new SchemaColumn("clientID", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("resourceOwnerIdentifier", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("issueDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn("expirationDate", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
      new SchemaColumn.relationship("token", ManagedPropertyType.string, relatedTableName: "_Token", relatedColumnName: "accessToken", rule: ManagedRelationshipDeleteRule.cascade, isNullable: true, isUnique: true),
    ]));

  }

  @override
  Future downgrade() async {
  }
  @override
  Future seed() async {
  }
}
