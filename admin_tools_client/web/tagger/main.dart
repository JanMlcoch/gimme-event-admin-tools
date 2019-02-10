import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';
import 'package:admin_tools/tagger/app_component.dart';
import 'package:admin_tools/tagger/services/events_service.dart';
import 'package:admin_tools/tagger/services/user_service.dart';

void main() {
  bootstrap(AppComponent, [provide(EventsService), provide(UserService)]);
}


