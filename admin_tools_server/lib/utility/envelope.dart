library admin_tools.envelope;

import 'dart:convert';

//import 'dart:io';
import 'package:aqueduct/aqueduct.dart';

class MessageEnvelope implements HTTPSerializable {
  final String message;
  const MessageEnvelope(this.message);

  @override
  String toString() {
    return JSON.encode({"message": message});
  }

  APIResponse document([int responseCode = 200]) {
    return new APIResponse()
      ..statusCode = responseCode
      ..description = message
      ..schema = new APISchemaObject(properties: {"message": new APISchemaObject.string()});
  }

  @override
  Map<String, String> asSerializable() {
    return {"message": message};
  }
}

class ErrorEnvelope implements HTTPSerializable {
  final String message;
  const ErrorEnvelope(this.message);

  @override
  String toString() {
    return JSON.encode({"error": message});
  }

  APIResponse document([int responseCode = 500]) {
    return new APIResponse()
      ..statusCode = responseCode
      ..description = message
      ..schema = new APISchemaObject(properties: {"error": new APISchemaObject.string()});
  }

  @override
  Map<String, String> asSerializable() {
    return {"error": message};
  }
}
