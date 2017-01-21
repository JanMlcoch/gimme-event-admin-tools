part of admin_tools.model;

class RepoVersion extends ManagedObject<_RepoVersion> implements _RepoVersion {

}

class _RepoVersion {
  @managedPrimaryKey
  int id;
  @ManagedColumnAttributes()
  String name;
  @ManagedColumnAttributes()
  String branchName;
  String repo;
//  @ManagedRelationship(#id, onDelete: ManagedRelationshipDeleteRule.cascade)
//  RepoVersion basedOn;
  @ManagedColumnAttributes(nullable: true)
  int basedOnId;

  @ManagedRelationship(#repoVersions, onDelete: ManagedRelationshipDeleteRule.cascade)
  User author;
  DateTime created;

  @ManagedColumnAttributes(defaultValue: 'FALSE')
  bool isGenerated;
  @ManagedColumnAttributes(nullable: true)
  DateTime deployed;

//  ManagedSet<RepoVersion> sourceFor;
}
