import 'package:aqueduct/aqueduct.dart';
import 'dart:async';

class Migration2 extends Migration {
  Future upgrade() async {
    database.commands=[";"];
  }

  Future downgrade() async {
  }
  Future seed() async {
    var clientSecret = "heslo Admin Tools pro Akcnik webovou aplikaci";
    var clientID = "Akcnik Admin tools";
    var salt = AuthServer.generateRandomSalt();
    var hashedPassword = AuthServer.generatePasswordHash(clientSecret, salt);
    return store.execute("INSERT INTO _Client (id,hashedpassword,salt) VALUES (@id,@password,@salt)",
        substitutionValues: {"id": clientID, "password": hashedPassword, "salt": salt});
  }
}
