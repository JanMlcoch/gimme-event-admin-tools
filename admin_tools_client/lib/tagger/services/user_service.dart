import 'dart:async';

import 'package:angular2/core.dart';
import 'package:admin_tools/tagger/model/library.dart';

import 'package:admin_tools/common/server_gateway/requests.dart' as gateway;

@Injectable()
class UserService {
  User user;
  bool get isUserLogged => user != null;

  void createLoggedUser(String login, String token){
    user = new User(login, token);
  }

  Future<String> login(String login, String password){
    return gateway.login(login, password);
  }
}