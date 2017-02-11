part of admin_tools.controller;

class BranchController extends HTTPController {
  @httpGet
  Future<Response> getBranches() async {
    Query<RepoVersion> query = new Query<RepoVersion>();
    query.sortDescriptors = [new QuerySortDescriptor("id", QuerySortOrder.descending)];
    query.resultProperties = ["branchName", "created"];
  }
}
