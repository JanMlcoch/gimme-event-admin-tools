part of admin_tools.model;

class User extends ManagedObject<_User> implements _User, Authenticatable{

}
class _User{
  @managedPrimaryKey
  int id;

  @ManagedColumnAttributes(unique: true, indexed: true)
  String username;

  @ManagedColumnAttributes(unique: true, indexed: true)
  String email;

  @ManagedColumnAttributes(omitByDefault: true)
  String hashedPassword;

  @ManagedColumnAttributes(omitByDefault: true)
  String salt;
}