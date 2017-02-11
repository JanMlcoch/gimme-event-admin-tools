part of admin_tools.controller;

class TaggedEventController extends HTTPController {
  @httpGet
  Future<Response> getEvents() async {
    Query<TaggedEvent> query = new Query<TaggedEvent>();
    List<TaggedEvent> events = await query.fetch();
    if (events == null) throw "bug";
    return new Response.ok(events);
  }

  @httpGet
  Future<Response> getEvent(@HTTPPath("id") String stringId) async {
    if (stringId == null || stringId == "") {
      return new Response.badRequest(body: const ErrorEnvelope("missing ID"));
    }
    Query<TaggedEvent> query = new Query<TaggedEvent>()
      ..matchOn.id = whereEqualTo(int.parse(stringId))
      ..fetchLimit = 1;
    TaggedEvent event = await query.fetchOne();
    return new Response.ok(event);
  }

  @httpPost
  Future<Response> saveEvent() async {
    Map<String, dynamic> body = requestBody;
    Map<String, dynamic> eventMap = body["event"];
    List<Map<String, dynamic>> tags = body["tags"];

    Query<TaggedEvent> insertQuery = new Query<TaggedEvent>();
    insertQuery.values
      ..event = eventMap
      ..tags = tags
      ..created = new DateTime.now()
      ..updated = new DateTime.now()
      ..userId = request.authorization.resourceOwnerIdentifier;
    TaggedEvent inserted = await insertQuery.insert();
    return new Response.ok(inserted);
  }

  @httpPut
  Future<Response> updateEvent(@requiredHTTPParameter @HTTPPath("id") String stringId) async {
    Map<String, dynamic> body = requestBody;
    Map<String, dynamic> eventMap = body["event"];
    List<Map<String, dynamic>> tags = body["tags"];

    bool isUpdating = stringId != null && stringId != "";
    if (!isUpdating) {
      return new Response.badRequest(body: const ErrorEnvelope("Missing ID path parameter"));
    }
    Query<TaggedEvent> eventToUpdateQuery = new Query<TaggedEvent>()
      ..matchOn.id = whereEqualTo(int.parse(stringId))
      ..fetchLimit = 1;
    TaggedEvent eventToUpdate = await eventToUpdateQuery.fetchOne();
    if (eventToUpdate == null) {
      return new Response.notFound(body: new ErrorEnvelope("missing event with id $stringId"));
    }
    Query<TaggedEvent> updateQuery = new Query<TaggedEvent>()
      ..matchOn.id = whereEqualTo(eventToUpdate.id)
//      ..values.event = eventMap
//      ..values.tags = tags
      ..values.updated = new DateTime.now()
      ..values.userId = request.authorization.resourceOwnerIdentifier
      ..fetchLimit = 1;
    if (eventMap != null) {
      updateQuery.values.event = eventMap;
    }
    if (tags != null) {
      updateQuery.values.tags = tags;
    }
    TaggedEvent updated = await updateQuery.updateOne();
    return new Response.ok(updated);
  }
  @override
  List<APIResponse> documentResponsesForOperation(APIOperation operation) {
    var responses = super.documentResponsesForOperation(operation);
    if (operation.id == APIOperation.idForMethod(this, #getEvents)) {
      responses.addAll([
        new APIResponse()
          ..statusCode = HttpStatus.OK
          ..description = "Get all tagged_events"
          ..schema =
          new APISchemaObject.fromTypeMirror(List)
      ]);
    }
    if (operation.id == APIOperation.idForMethod(this, #getEvent)) {
      responses.addAll([
      new APIResponse()
        ..statusCode = HttpStatus.OK
        ..description = "Get tagged_event with id"
        ..schema =
        new APISchemaObject.fromTypeMirror(TaggedEvent),
      const ErrorEnvelope("missing ID").document(HttpStatus.NOT_FOUND)
      ]);
    }
    if (operation.id == APIOperation.idForMethod(this, #saveEvent)) {
      responses.addAll([
      new APIResponse()
        ..statusCode = HttpStatus.OK
        ..description = "Save tagged_event"
        ..schema =
        new APISchemaObject.fromTypeMirror(TaggedEvent),
//      const ErrorEnvelope("missing ID").document(HttpStatus.NOT_FOUND)
      ]);
    }
    if (operation.id == APIOperation.idForMethod(this, #updateEvent)) {
      responses.addAll([
      new APIResponse()
        ..statusCode = HttpStatus.OK
        ..description = "Update tagged_event with ID"
        ..schema =
        new APISchemaObject.fromTypeMirror(TaggedEvent),
      const ErrorEnvelope("missing event with id \$stringId").document(HttpStatus.NOT_FOUND)
      ]);
    }
    return responses;
  }
}
