part of admin_tools.controller;

class IdentityController extends HTTPController {
  @requiredHTTPParameter
  @HTTPHeader(HttpHeaders.AUTHORIZATION)
  String authHeader;

  @httpGet
  Future<Response> getIdentity() async {
    var q = new Query<User>()..matchOn.id = request.authorization.resourceOwnerIdentifier;

    var u = await q.fetchOne();
    if (u == null) {
      return new Response.notFound();
    }

    return new Response.ok(u);
  }

  @override
  List<APIResponse> documentResponsesForOperation(APIOperation operation) {
    var responses = super.documentResponsesForOperation(operation);
    if (operation.id == APIOperation.idForMethod(this, #getIdentity)) {
      responses.addAll([
        new APIResponse()
          ..statusCode = HttpStatus.OK
          ..description = "User is logged"
          ..schema = new APISchemaObject.fromTypeMirror(reflectType(User)),
        new APIResponse()
          ..statusCode = HttpStatus.BAD_REQUEST
          ..description = "User not found."
          ..schema = new APISchemaObject(properties: {"error": new APISchemaObject.string()}),
      ]);
    }

    return responses;
  }
}
