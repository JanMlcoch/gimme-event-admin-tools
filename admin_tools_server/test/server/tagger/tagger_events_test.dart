import '../../mock/startup.dart';
import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:test/test.dart';
import 'package:admin_tools/admin_tools.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start(3574);
    Query<TaggedEvent> event1Query = new Query<TaggedEvent>();
    event1Query.values
      ..event = {"id": 25, "name": "Event 1"}
      ..userId = 1
      ..tags = [
        {"id": 1, "name": "pivo"},
        {"id": 2, "name": "larp"}
      ]
      ..created = new DateTime.now()
      ..updated = new DateTime.now();
    Query<TaggedEvent> event2Query = new Query<TaggedEvent>();
    event2Query.values
      ..event = {"id": 26, "name": "Event 2"}
      ..userId = 1
      ..tags = [
        {"id": 1, "name": "pivo"}
      ]
      ..created = new DateTime.now()
      ..updated = new DateTime.now();
    return Future.wait([event1Query.insert(), event2Query.insert()]);
  });
  tearDownAll(() {
    return app.stop();
  });
  group("Tagged Events - Success", () {
    test("get all events", () async {
      var req = app.client.authenticatedRequest("/api/tagged_events");
      var result = await req.get();

      expect(
          result,
          hasResponse(
              200,
              everyElement(partial({
                "id": greaterThan(0),
                "event": partial({"name": contains("Event")})
              }))));
      expect(result.asList.length, equals(2));
    });
    test("get one event", () async {
      var req = app.client.authenticatedRequest("/api/tagged_events/2");
      var result = await req.get();
      expect(
          result,
          hasResponse(
              200,
              partial({
                "event": partial({"name": equals("Event 2")})
              })));
    });
    test("insert new event", () async {
      var req = app.client.authenticatedRequest("/api/tagged_events");
      req.json = {
        "event": {"name": "BarbarLarp"},
        "tags": [
          {"id": 1, "name": "pivo"},
          {"id": 2, "name": "larp"},
          {"id": 3, "name": "les"}
        ]
      };
      var result = await req.post();
      expect(
          result,
          hasResponse(
              200,
              partial({
                "event": partial({"name": "BarbarLarp"})
              })));
      var req2 = app.client.authenticatedRequest("/api/tagged_events");
      var result2 = await req2.get();
      expect(result2.asList.length, equals(3));
    });
    test("update event", () async {
      var req = app.client.authenticatedRequest("/api/tagged_events/1");
      List<Map> tags = [
        {"id": 1, "name": "pivo"},
        {"id": 2, "name": "larp"},
        {"id": 3, "name": "les"}
      ];
      req.json = {"tags": tags};
      var result = await req.put();
      expect(result, hasResponse(200, partial({"event": isNotNull})));
      var req2 = app.client.authenticatedRequest("/api/tagged_events/1");
      var result2 = await req2.get();
      expect(
          result2,
          hasResponse(
              200,
              partial({
                "event": partial({"name": "Event 1"}),
                "tags": equals(tags)
              })));
    });
  });
}
