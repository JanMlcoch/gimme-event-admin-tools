library admin_tools.envelope;

import 'dart:convert';

//import 'dart:io';
import 'package:aqueduct/aqueduct.dart';

class MessageEnvelope{
  final String message;
  MessageEnvelope(this.message);

  String toString(){
    return JSON.encode({"message":message});
  }
  APIResponse document([int responseCode=200]){
    return new APIResponse()
      ..statusCode = responseCode
      ..description = message
      ..schema = new APISchemaObject(properties: {
        "message":new APISchemaObject.string()
      });
  }
}

class ErrorEnvelope{
  final String message;
  ErrorEnvelope(this.message);

  String toString(){
    return JSON.encode({"error":message});
  }
  APIResponse document([int responseCode=500]){
    return new APIResponse()
      ..statusCode = responseCode
      ..description = message
      ..schema = new APISchemaObject(properties: {
        "error":new APISchemaObject.string()
      });
  }
}