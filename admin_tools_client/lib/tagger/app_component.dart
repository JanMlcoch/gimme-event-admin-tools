import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:admin_tools/tagger/events_list_component.dart';
import 'package:admin_tools/tagger/event_component.dart';
import 'package:admin_tools/tagger/services/events_service.dart';

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
])
class AppComponent{
  final EventsService _eventsService;
  AppComponent(this._eventsService);

  save(){
    print("saved: ${_eventsService.events.toMap()}");
  }
}


@Component(
    selector: 'empty',
    template: '',
    directives: const [],
    providers: const [])
class EmptyComponent{}