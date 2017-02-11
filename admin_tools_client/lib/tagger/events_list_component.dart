import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:admin_tools/tagger/services/events_service.dart';
import 'package:admin_tools/tagger/model/library.dart';

@Component(
  selector: "events-list-component",
  templateUrl: "events_list_component.html",
  styleUrls: const ["events_list_component.css"],
  directives: const [
    materialDirectives,
    ROUTER_DIRECTIVES
  ],
  providers: const [
    materialProviders,
    ROUTER_PROVIDERS,
    EventsService
  ])
class EventsListComponent{
  final EventsService _eventsService;
  List<double> _columns = [40.0, 20.0, 10.0, 30.0];
  List<String> get columns => ['${_columns[0]}%', '${_columns[1]}%', '${_columns[2]}%', '${_columns[3]}%'];

  String width = "200";

  Events get events => _eventsService.events;

  EventsListComponent(this._eventsService);
}