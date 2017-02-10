part of admin_tools.model;

class AuthCode extends ManagedObject<_AuthCode> implements _AuthCode {}
class _AuthCode implements AuthTokenExchangable<Token> {
  @managedPrimaryKey
  int id;

  @ManagedColumnAttributes(indexed: true)
  @override
  String code;

  @ManagedColumnAttributes(nullable: true)
  @override
  String redirectURI;

  @override
  String clientID;
  @override
  int resourceOwnerIdentifier;
  @override
  DateTime issueDate;
  @override
  DateTime expirationDate;

  @override
  @ManagedRelationship(#code, isRequired: false, onDelete: ManagedRelationshipDeleteRule.cascade)
  Token token;
}

class Token extends ManagedObject<_Token> implements _Token, AuthTokenizable<int> {
  @override
  String get clientID => client.id;
  @override
  set clientID(cid) {
    client = new ClientRecord()..id = cid;
  }
  @override
  int get resourceOwnerIdentifier => owner.id;
  @override
  set resourceOwnerIdentifier(roid) {
    owner = new User()..id = roid;
  }
}
class _Token {
  @ManagedColumnAttributes(primaryKey: true)
  String accessToken;

  @ManagedColumnAttributes(indexed: true)
  String refreshToken;

  @ManagedRelationship(#tokens, onDelete: ManagedRelationshipDeleteRule.cascade)
  ClientRecord client;

  @ManagedRelationship(#tokens, onDelete: ManagedRelationshipDeleteRule.cascade)
  User owner;

  AuthCode code;

  DateTime issueDate;
  DateTime expirationDate;
  String type;
}

class ClientRecord extends ManagedObject<_Client> implements _Client {}
class _Client {
  @ManagedColumnAttributes(primaryKey: true)
  String id;

  ManagedSet<Token> tokens;

  String hashedPassword;
  String salt;
}
