part of admin_tools.controller;

class RepoController extends HTTPController {
  @httpGet
  Future<Response> getRepo(@HTTPPath("branch") String branchName) async {
    Query<RepoVersion> query = new Query<RepoVersion>();
    query.sortDescriptors = [new QuerySortDescriptor('id', QuerySortOrder.descending)];
    if (branchName != "") {
      query.matchOn.branchName = whereEqualTo(branchName);
    }
    List<RepoVersion> repoVersions = await query.fetch();
    if (repoVersions.length == 0) {
      return new Response.notFound(body: "No repo with selected branchName");
    }
    return new Response.ok(repoVersions[0]);
  }

  @httpPost
  Future<Response> saveRepo(@HTTPPath("branch") String branchName) async {
    Map<String, dynamic> body = requestBody;

    Query<RepoVersion> basedQuery = new Query<RepoVersion>();
    basedQuery.matchOn.id = whereEqualTo(body["basedOnId"]);
    RepoVersion basedOn = await basedQuery.fetchOne();
    if (basedOn == null) {
      return new Response.notFound(body: "Missing basedOn repo");
    }
    if (branchName == null || branchName == "") {
      branchName = body["branchName"];
    }
    if (branchName == null || branchName == "") {
      branchName = basedOn.branchName;
    }
    if (branchName == null || branchName == "") {
      return new Response.badRequest(body: "missing branchName");
    }

    Query<RepoVersion> query = new Query<RepoVersion>();
    query.values
      ..author = (new User()..id = request.authorization.resourceOwnerIdentifier)
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
