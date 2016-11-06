part of admin_tools.utility;

class AdminAuthenticationDelegate implements aque.AuthServerDelegate<User, Token, AuthCode> {
  Future<aque.AuthClient> clientForID(aque.AuthServer server, String id) async {
    var clientQ = new aque.Query<ClientRecord>()
      ..matchOn.id = id;

    var clientRecord = await clientQ.fetchOne();
    if (clientRecord == null) {
      return null;
    }

    return new aque.AuthClient(clientRecord.id, clientRecord.hashedPassword, clientRecord.salt);
  }

  Future deleteTokenForRefreshToken(aque.AuthServer server, String refreshToken) async {
    var q = new aque.Query<Token>()
      ..matchOn.refreshToken = refreshToken;

    await q.delete();
  }

  Future updateToken(aque.AuthServer server, Token t) async {
    var tokenQ = new aque.Query<Token>()
      ..matchOn.refreshToken = t.refreshToken
      ..values = t;

    return tokenQ.updateOne();
  }

  Future<Token> tokenForAccessToken(aque.AuthServer server, String accessToken) {
    var tokenQ = new aque.Query<Token>()
      ..matchOn.accessToken = accessToken;

    return tokenQ.fetchOne();
  }

  Future<Token> tokenForRefreshToken(aque.AuthServer server, String refreshToken) {
    var tokenQ = new aque.Query<Token>()
      ..matchOn.refreshToken = refreshToken;

    return tokenQ.fetchOne();
  }

  Future<User> authenticatableForUsername(aque.AuthServer server, String username) async {
    var userQ = new aque.Query<User>()
      ..matchOn.email = username
      ..resultProperties = ["email", "hashedPassword", "salt", "id"];

    return await userQ.fetchOne();
  }

  Future<User> authenticatableForID(aque.AuthServer server, dynamic id) async {
    var userQ = new aque.Query<User>()
      ..matchOn.id = id
      ..resultProperties = ["email", "hashedPassword", "salt", "id"];

    return await userQ.fetchOne();
  }

  Future deleteTokenForAccessToken(aque.AuthServer server, String accessToken) async {
    var q = new aque.Query<Token>()
      ..matchOn.accessToken = accessToken;

    await q.delete();
  }

  Future<Token> storeToken(aque.AuthServer server, Token t) async {
    var oldTokenQ = new aque.Query<Token>()
      ..matchOn.client= aque.whereRelatedByValue(t.client.id)
    ..matchOn.owner=aque.whereRelatedByValue(t.owner.id);
    await oldTokenQ.delete();

    var tokenQ = new aque.Query<Token>();
    tokenQ.values = t;

    var insertedToken = await tokenQ.insert();

    pruneResourceOwnerTokensAfterIssuingToken(t).catchError((e) {
      new aque.Logger("aqueduct").severe("Failed to prune tokens $e");
    });

    return insertedToken;
  }

  Future<AuthCode> storeAuthCode(aque.AuthServer server, AuthCode code) async {
//    var authCodeQ = new Query<AuthCode>();
//    authCodeQ.values = code;
//    return authCodeQ.insert();
  return null;
  }

  Future<AuthCode> authCodeForCode(aque.AuthServer server, String code) async {
//    var authCodeQ = new Query<AuthCode>()
//      ..matchOn.code = code;
//
//    return authCodeQ.fetchOne();
  return null;
  }

  Future updateAuthCode(aque.AuthServer server, AuthCode code) async {
//    var authCodeQ = new Query<AuthCode>()
//      ..matchOn.id = code.id
//      ..values = code;
//
//    return authCodeQ.updateOne();
  return null;
  }

  Future deleteAuthCode(aque.AuthServer server, AuthCode code) async {
//    var authCodeQ = new Query<AuthCode>()
//      ..matchOn.id = code.id;
//
//    return authCodeQ.delete();
  return null;
  }

  Future pruneResourceOwnerTokensAfterIssuingToken(Token t, {int count: 25}) async {
    var tokenQ = new aque.Query<Token>()
      ..matchOn.owner = aque.whereRelatedByValue(t.owner.id)
      ..matchOn.client = aque.whereRelatedByValue(t.client.id)
      ..sortDescriptors = [new aque.QuerySortDescriptor("issueDate", aque.QuerySortOrder.descending)]
      ..offset = 24
      ..fetchLimit = 1
      ..resultProperties = ["issueDate"];

    var results = await tokenQ.fetch();
    if (results.length == 1) {
      var deleteQ = new aque.Query<Token>()
        ..matchOn.owner = aque.whereRelatedByValue(t.owner.id)
        ..matchOn.client = aque.whereRelatedByValue(t.client.id)
        ..matchOn.issueDate = aque.whereLessThan(results.first.issueDate);

      await deleteQ.delete();
    }
  }
}