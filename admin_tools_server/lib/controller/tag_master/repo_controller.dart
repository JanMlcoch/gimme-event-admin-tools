part of admin_tools.controller;

class RepoController extends HTTPController {
  @httpGet
  Future<Response> getRepo(@HTTPPath("branch") String branchName) async {
    Query<RepoVersion> query = new Query<RepoVersion>();
    query.sortDescriptors = [new QuerySortDescriptor('id', QuerySortOrder.descending)];
    if (branchName != null) {
      query.matchOn.branchName = whereEqualTo(branchName);
    }
    List<RepoVersion> repos = await query.fetch();
//    var repoVersion = await query.fetchOne();
    print("repos.length=${repos.length}");
    RepoVersion repoVersion;
    if (repoVersion == null) {
      return new Response.notFound(body: "No repo with selected branchName");
    }
    return new Response.ok(repoVersion);
  }

  @httpPost
  Future<Response> saveRepo(@HTTPPath("branch") String branchName) async {
    Map<String, dynamic> body = requestBody;

    Query<RepoVersion> basedQuery = new Query<RepoVersion>();
    basedQuery.matchOn.id = whereEqualTo(body["basedOnId"]);
    RepoVersion basedOn = await basedQuery.fetchOne();
    if (basedOn == null) {
      return new Response.notFound(body: "blbe");
    }
    if (branchName == null) {
      branchName = basedOn.branchName;
    }

    Query<RepoVersion> query;
    query.values
      ..author = request.authorization.resourceOwnerIdentifier
      ..created = new DateTime.now()
      ..branchName = branchName
      ..repo = body["repo"]
      ..name = body["name"]
      ..basedOnId = basedOn.id;

    RepoVersion createdVersion = await query.insert();
    return new Response.ok(createdVersion);
  }

  @override
  List<APIResponse> documentResponsesForOperation(APIOperation operation) {
    var responses = super.documentResponsesForOperation(operation);
    if (operation.id == APIOperation.idForMethod(this, #getRepo)) {
      responses.addAll([
        new APIResponse()
          ..statusCode = HttpStatus.OK
          ..description = "Get last repo from {{branch}}. If omitted, default branch is downloaded"
          ..schema = new APISchemaObject.fromTypeMirror(reflectType(RepoVersion)),
        new APIResponse()
          ..statusCode = HttpStatus.NOT_FOUND
          ..description = "Repo not found."
          ..schema = new APISchemaObject(properties: {"error": new APISchemaObject.string()}),
      ]);
    }
    if (operation.id == APIOperation.idForMethod(this, #saveRepo)) {
      responses.addAll([
        new APIResponse()
          ..statusCode = HttpStatus.OK
          ..description = "Save repo with into {{branch}}. If omitted, default branch name is used"
          ..schema = new APISchemaObject.fromTypeMirror(reflectType(RepoVersion)),
        new APIResponse()
          ..statusCode = HttpStatus.NOT_FOUND
          ..description = "Source version is not found."
          ..schema = new APISchemaObject(properties: {"error": new APISchemaObject.string()}),
      ]);
    }
    return responses;
  }
}
