import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration2 extends Migration {
  @override
  Future upgrade() async {
    database.commands = [";"];
  }

  @override
  Future downgrade() async {}
  @override
  Future seed() async {
    var clientSecret = "heslo Admin Tools pro Akcnik webovou aplikaci";
    var clientID = "Akcnik Admin tools";
    var clientSalt = AuthServer.generateRandomSalt();
    var clientHashedPassword = AuthServer.generatePasswordHash(clientSecret, clientSalt);
    var adminName = "admin";
    var adminEmail = "ringael@centrum.cz";
    var adminPassword = "velmi_slozite_heslo";
    var adminSalt = AuthServer.generateRandomSalt();
    var adminHashedPassword = AuthServer.generatePasswordHash(adminPassword, adminSalt);
    await store.execute("INSERT INTO _Client (id,hashedpassword,salt) VALUES (@id,@password,@salt);",
        substitutionValues: {"id": clientID, "password": clientHashedPassword, "salt": clientSalt});
    await store.execute(
        "INSERT INTO _User (username,email,hashedpassword,salt) VALUES (@username,@email,@password,@salt);",
        substitutionValues: {
          "username": adminName,
          "email": adminEmail,
          "password": adminHashedPassword,
          "salt": adminSalt
        });
    var meSalt= AuthServer.generateRandomSalt();
    await store.execute(
        "INSERT INTO _User (username,email,hashedpassword,salt) VALUES (@username,@email,@password,@salt);",
        substitutionValues: {
          "username": "me",
          "email": "cosi@akcnik.cz",
          "password": AuthServer.generatePasswordHash("aaa",meSalt),
          "salt": meSalt
        });
  }
}
