import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:admin_tools/tagger/model/library.dart';
import 'package:admin_tools/tagger/services/events_service.dart';

import 'package:admin_tools/tagger/ui_components/smart_select_component.dart';

@Component(
    selector: "event-detail",
    templateUrl: "event_component.html",
    styleUrls: const ["event_component.css"],
    directives: const [
      materialDirectives,
      ROUTER_DIRECTIVES,
      SmartSelectComponent,
    ],
    providers: const [
      materialProviders,
      ROUTER_PROVIDERS
    ])
class EventDetailComponent implements OnInit{
  final RouteParams _routeParams;
  final EventsService _eventService;
  bool hasData = false;
  GimmeEvent event;
  int eventId;

  EventDetailComponent(this._routeParams, this._eventService);

  @override
  void ngOnInit() {
    var _eventIdString = _routeParams.get('id');
    _eventIdString = _eventIdString != null ? _eventIdString : "";
    eventId = int.parse(_eventIdString, onError: (_) {
      throw new Exception("Parsing of tagId from routing parameters failed");
    });
    event = _eventService.events.events.firstWhere((GimmeEvent e) => e.id == eventId, orElse: (){
      print("not found");
      return null;
    });
    if(event != null){
      hasData = true;
      _eventService.selected = event;
    }

  }
}