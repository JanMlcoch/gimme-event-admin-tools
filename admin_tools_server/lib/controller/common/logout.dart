part of admin_tools.controller;

class LogoutController extends HTTPController {
  @httpPost
  Future<Response> logout() async {
    Query<Token> query = new Query<Token>()
      ..matchOn.client = whereRelatedByValue(request.authorization.clientID)
      ..matchOn.owner = whereRelatedByValue(request.authorization.resourceOwnerIdentifier);
    int rowCount = await query.delete();
    if (rowCount > 0) return new Response.ok(const MessageEnvelope("Succesfully logout"));
    return new Response.notFound(body: const ErrorEnvelope("Cannot logout, probably already logged out"));
  }

  @override
  List<APIResponse> documentResponsesForOperation(APIOperation operation) {
    var responses = super.documentResponsesForOperation(operation);
    if (operation.id == APIOperation.idForMethod(this, #logout)) {
      responses.addAll([
        const MessageEnvelope("Succesfully logout").document(HttpStatus.OK),
        const ErrorEnvelope("Cannot logout, probably already logged out").document(HttpStatus.BAD_REQUEST)
      ]);
    }

    return responses;
  }
}
