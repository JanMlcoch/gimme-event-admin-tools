import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:admin_tools/tagger/services/user_service.dart';
import 'package:admin_tools/tagger/services/events_service.dart';
import 'package:admin_tools/tagger/model/library.dart';

import 'package:admin_tools/tagger/events_list_component.dart';
import 'package:admin_tools/tagger/event_component.dart';
import 'package:admin_tools/tagger/dialogs/login_component.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    styleUrls: const ['app_component.css'],
    directives: const [
      materialDirectives,
      ROUTER_DIRECTIVES,
      EventsListComponent
    ],
    providers: const [
      materialProviders,
      ROUTER_PROVIDERS
    ])
@RouteConfig(const [
  const Route(path: '/', name: 'Empty', component: EmptyComponent),
  const Route(path: '/event/:id', name: 'Event', component: EventDetailComponent),
  const Route(path: '/login', name: 'Login', component: LoginDialogComponent),
])
class AppComponent{
  final UserService _userService;
  final EventsService _eventsService;

  User get user => _userService.user;

  bool get isUserLogged => _userService.isUserLogged;

  AppComponent(this._userService, this._eventsService);

  void save(){

  }
}

@Component(
    selector: 'empty',
    template: '',
    directives: const [],
    providers: const [])
class EmptyComponent{}