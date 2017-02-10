import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
    selector: "event-detail",
    templateUrl: "event_component.html",
    styleUrls: const ["event_component.css"],
    directives: const [
      materialDirectives,
      ROUTER_DIRECTIVES
    ],
    providers: const [
      materialProviders,
      ROUTER_PROVIDERS
    ])
class EventDetailComponent{

}