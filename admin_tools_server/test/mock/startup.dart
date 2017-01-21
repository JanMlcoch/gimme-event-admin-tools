import 'package:aqueduct/aqueduct.dart' as aque;
import 'package:scribe/scribe.dart';
import 'dart:async';
import 'package:admin_tools/lib/library.dart';
import 'package:admin_tools/admin_tools.dart' show ClientRecord, User, Token;

class TestApplication {
  TestApplication() {
    configuration = new AdminConfiguration("config.yaml.src");
    configuration.database.isTemporary = true;
  }

  aque.Application<AdminSink> application;
  AdminSink get sink => application.mainIsolateSink;
  LoggingServer logger = new LoggingServer([]);
//  LoggingServer logger = new LoggingServer([new ConsoleBackend()]);
  aque.TestClient client;
  AdminConfiguration configuration;

  Future start(int port) async {
    await logger.start();

    application = new aque.Application<AdminSink>();
    application.configuration
      ..configurationOptions = {
        AdminSink.ConfigurationKey: configuration,
        AdminSink.LoggingTargetKey: logger.getNewTarget()
      }
      ..port = port;

    await application.start(runOnMainIsolate: true);

    aque.ManagedContext.defaultContext = sink.context;

    await createDatabaseSchema(sink.context, sink.logger);
    ClientRecord testClientRecord = await addClientRecord();
    User testUser = await addTestAdminUser();
    Token testToken = await addDefaultToken(testUser, testClientRecord);

    client = new aque.TestClient(application)
      ..clientID = "Test Admin tools"
      ..clientSecret = "testovaci heslo pouze pro testy"
      ..defaultAccessToken = testToken.accessToken;
  }

  Future stop() async {
    await sink.context.persistentStore?.close();
    await logger?.stop();
    await application?.stop();
  }

  static Future<ClientRecord> addClientRecord(
      {String clientID: "Test Admin tools", String clientSecret: "testovaci heslo pouze pro testy"}) async {
    var salt = aque.AuthServer.generateRandomSalt();
    var hashedPassword = aque.AuthServer.generatePasswordHash(clientSecret, salt);
    var testClientRecord = new ClientRecord();
    testClientRecord.id = clientID;
    testClientRecord.salt = salt;
    testClientRecord.hashedPassword = hashedPassword;

    var clientQ = new aque.Query<ClientRecord>()
      ..values.id = clientID
      ..values.salt = salt
      ..values.hashedPassword = hashedPassword;
    return clientQ.insert();
  }

  static Future<User> addTestAdminUser(
      {String userName: "test_user", String userPassword: "test_user_xxx_password"}) async {
    var salt = aque.AuthServer.generateRandomSalt();
    var hashedPassword = aque.AuthServer.generatePasswordHash(userPassword, salt);

    var userQ = new aque.Query<User>()
      ..values.username = userName
      ..values.email = "$userName@akcnik.cz"
      ..values.salt = salt
      ..values.hashedPassword = hashedPassword;
    return userQ.insert();
  }

  static Future addDefaultToken(User testUser, ClientRecord client, {String accessToken: "test_token"}) async {
    aque.Query<Token> query = new aque.Query<Token>()
      ..values.accessToken = accessToken
      ..values.refreshToken = "refresh_$accessToken"
      ..values.issueDate = new DateTime.now()
      ..values.expirationDate = new DateTime.now().add(new Duration(minutes: 1))
      ..values.type = "token"
      ..values.client = client
      ..values.owner = testUser;
    return query.insert();
  }

  static Future createDatabaseSchema(aque.ManagedContext context, aque.Logger logger) async {
    var builder = new aque.SchemaBuilder.toSchema(
        context.persistentStore, new aque.Schema.fromDataModel(context.dataModel),
        isTemporary: true);

    for (var cmd in builder.commands) {
      logger?.info("$cmd");
      await context.persistentStore.execute(cmd);
    }
  }
}
