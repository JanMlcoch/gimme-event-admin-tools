import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:scribe/scribe.dart';
import 'package:admin_tools/lib/library.dart';

Future main() async {
  try {
    var configFileName = "config.yaml";
    var logPath = "api.log";

    var config = new AdminConfiguration(configFileName);
    var logger = new LoggingServer([new RotatingLoggingBackend(logPath)]);
    await logger.start();

    var app = new Application<AdminSink>();
    app.configuration.port = config.port;
    app.configuration.configurationOptions = {
      AdminSink.LoggingTargetKey : logger.getNewTarget(),
      AdminSink.ConfigurationKey : config
    };

    await app.start(numberOfInstances: 3);

    var signalPath = new File(".aqueductsignal");
    await signalPath.writeAsString("ok");
  } on ApplicationSupervisorException catch (e, st) {
    await writeError("IsolateSupervisorException, server failed to start: ${e.message} $st");
  } catch (e, st) {
    await writeError("Server failed to start: $e $st");
  }
}

Future writeError(String error) async {
  var file = new File("error.log");
  await file.writeAsString(error);
}
