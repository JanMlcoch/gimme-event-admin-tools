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
    materialProviders
  ])
class EventsListComponent{
  final EventsService _eventsService;
  final Router _router;
  List<double> _columns = [40.0, 20.0, 5.0, 25.0, 10.0];
  List<String> get columns => ['${_columns[0]}%', '${_columns[1]}%', '${_columns[2]}%', '${_columns[3]}%', '${_columns[4]}%'];

  String width = "200";

  GimmeEvents get events => _eventsService.events;
  EventsService get eventsService => _eventsService;

  EventsListComponent(this._eventsService, this._router);

  void selectEvent(GimmeEvent event){
    _eventsService.selected = event;
    _router.navigate(["Event", {'id': event.id}]);
  }

  void deleteEvent(GimmeEvent event){
    events.events.remove(event);
  }
}