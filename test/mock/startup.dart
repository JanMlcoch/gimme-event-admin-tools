import 'package:aqueduct/aqueduct.dart' as aque;
import 'package:scribe/scribe.dart';
import 'dart:async';
import '../../server/lib/library.dart';
import '../../server/model/library.dart' show ClientRecord;

class TestApplication {
  TestApplication() {
    configuration = new AdminConfiguration("config.yaml.src");
    configuration.database.isTemporary = true;
  }

  aque.Application<AdminSink> application;
  AdminSink get sink => application.mainIsolateSink;
  LoggingServer logger = new LoggingServer([/*new ConsoleBackend()*/]);
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
    await addClientRecord();

    client = new aque.TestClient(application)
      ..clientID = "com.aqueduct.test"
      ..clientSecret = "kilimanjaro";
  }

  Future stop() async {
    await sink.context.persistentStore?.close();
    await logger?.stop();
    await application?.stop();
  }

  static Future addClientRecord({String clientID: "com.aqueduct.test", String clientSecret: "kilimanjaro"}) async {
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
    await clientQ.insert();
  }

  static Future createDatabaseSchema(aque.ManagedContext context, aque.Logger logger) async {
    var builder = new aque.SchemaBuilder.toSchema(context.persistentStore, new aque.Schema.fromDataModel(context.dataModel),
        isTemporary: true);

    for (var cmd in builder.commands) {
      logger?.info("$cmd");
      await context.persistentStore.execute(cmd);
    }
  }
}
