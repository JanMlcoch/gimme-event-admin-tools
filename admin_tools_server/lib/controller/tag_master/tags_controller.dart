part of admin_tools.controller;

class TagsController extends HTTPController {
  @httpGet
  Future<Response> getTags() async {
    Query<RepoVersion> query = new Query<RepoVersion>()
      ..fetchLimit = 1
      ..sortDescriptors = [new QuerySortDescriptor("created", QuerySortOrder.descending)];
    RepoVersion repo = await query.fetchOne();
    if (repo == null) {
      return new Response.notFound(body: const ErrorEnvelope("missing repoVersion"));
    }
    if (repo.repo == null || repo.repo == "") {
      return new Response.badRequest(body: const ErrorEnvelope("missing repo in repoVersion"));
    }
    Map<String, List<Map<String, dynamic>>> convertedRepo = JSON.decode(repo.repo);
    if (convertedRepo["tags"] is! List) {
      return new Response.badRequest(body: const ErrorEnvelope("missing repo[\"tags\"] is not List"));
    }
    List<Map<String, dynamic>> tagList = convertedRepo["tags"];
    return new Response.ok(
        tagList.map((Map<String, dynamic> tag) => {"id": tag["id"], "name": tag["name"]}).toList(growable: false));
  }

  @httpGet
  Future<Response> getTag(@HTTPPath("id") String isString) async {
    return new Response(HttpStatus.NOT_IMPLEMENTED, null, const ErrorEnvelope("Not implemented"));
  }

  @override
  List<APIResponse> documentResponsesForOperation(APIOperation operation) {
    var responses = super.documentResponsesForOperation(operation);
    if (operation.id == APIOperation.idForMethod(this, #getTags)) {
      responses.addAll([
        new APIResponse()
          ..statusCode = HttpStatus.OK
          ..description = "Get tags from last repo"
          ..schema =
              new APISchemaObject(properties: {"id": new APISchemaObject.int(), "name": new APISchemaObject.string()}),
        const ErrorEnvelope("missing repoVersion").document(HttpStatus.NOT_FOUND),
        const ErrorEnvelope("missing repo in repoVersion").document(HttpStatus.NOT_FOUND),
        const ErrorEnvelope("missing repo[\"tags\"] is not List").document(HttpStatus.NOT_FOUND)
      ]);
    }
    if (operation.id == APIOperation.idForMethod(this, #getTag)) {
      responses.addAll([
//        new APIResponse()
//          ..statusCode = HttpStatus.OK
//          ..description = "Save repo with into {{branch}}. If omitted, default branch name is used"
//          ..schema = new APISchemaObject.fromTypeMirror(reflectType(RepoVersion)),
        const ErrorEnvelope("Not implemented").document(HttpStatus.NOT_IMPLEMENTED)
      ]);
    }
    return responses;
  }
}
