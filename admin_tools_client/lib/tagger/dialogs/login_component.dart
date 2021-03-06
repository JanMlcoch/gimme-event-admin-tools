
import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:admin_tools/tagger/model/library.dart';
import 'package:admin_tools/tagger/services/user_service.dart';

@Component(
    selector: 'dialog-login',
    styleUrls: const ['login_component.css'],
    templateUrl: 'login_component.html',
    directives: const [
      materialDirectives,
      ROUTER_DIRECTIVES
    ],
    providers: const [
      materialProviders,
      ROUTER_PROVIDERS
    ])
class LoginDialogComponent{
  final UserService _userService;
  final Router _router;

  bool showDialog = true;
  bool submitted = false;
  bool valid = false;
  UserLoginModel model = new UserLoginModel("admin", "velmi_slozite_heslo");

  LoginDialogComponent(this._userService, this._router);

  void onSubmit(){
    Future request = _userService.login(model.login, model.password);
    request.then((String message){
      try{
        Map responds = JSON.decode(message);
        if(responds.containsKey('access_token')){
          valid = true;
          _userService.createLoggedUser(model.login, responds['access_token']);
          showDialog = false;
          _router.navigate(['Empty']);
        }else{
          valid = false;
        }
      }catch(e){
        valid = false;
      }
      submitted = true;
    });
  }

  void moveToForgotten(){
    _router.navigate(['ForgottenPassword']);
  }

  void resetForm(){
    submitted = false;
  }
}

class UserLoginModel{
  String login;
  String password;

  UserLoginModel(this.login, this.password);

}