part of admin_tools.controller;

class RegisterController extends QueryController<User> {
  RegisterController() {
    acceptedContentTypes = [ContentType.JSON];
  }
  @httpPost
  Future<Response> createUser() async {
    if (request.authorization.resourceOwnerIdentifier != 1) {
      return new Response.unauthorized(body: "You are not allowed to create users");
    }
    if (query.values.username == null || query.values.password == null) {
      return new Response.badRequest(body: {"error": "Username and password required."});
    }
    if (query.values.email == null) {
      return new Response.badRequest(body: {"error": "Email required."});
    }

    var salt = AuthServer.generateRandomSalt();
    var hashedPassword = AuthServer.generatePasswordHash(query.values.password, salt);
    query.values.hashedPassword = hashedPassword;
    query.values.salt = salt;

    var u = await query.insert();

    return new Response.ok(u);
//    var credentials = AuthorizationBasicParser.parse(request.innerRequest.headers.value(HttpHeaders.AUTHORIZATION));
//    var token = await request.authorization.grantingServer
//        .authenticate(u.username, query.values.password, request.authorization.clientID, credentials.password);
//
//    return AuthController.tokenResponse(token);
  }
}
