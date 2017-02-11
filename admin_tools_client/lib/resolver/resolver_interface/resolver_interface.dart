library resolver_interface;

import 'dart:convert';

import 'package:admin_tools/resolver/computor/library.dart';
import 'package:admin_tools/sidos_entities/library.dart';

void main() {}

void setUpUniverse(List<Map<String, dynamic>> users, List<Map<String, dynamic>> events) {
  Imprintificator.instance;

  Map<int, Imprint> imprints;
  Map<int, UserPattern> patterns;
  List<int> realEventIds = imprints.keys;

  for (Map<String, dynamic> event in events) {
    List<int> tagIds = [];
    for (Map<String, dynamic> tag in event["tags"]) {
      tagIds.add(tag["id"]);
    }
    Imprint imprint = Imprintificator.instance.createImprint(tagIds, new GPS.withValues(0.0, 0.0));
    imprints[event["id"]] = imprint;
  }

  Cachor.instance.eventImprints = JSON.decode(JSON.encode(imprints));

  for (Map<String, dynamic> user in users) {
    List<Imprint> mockImprints;
    for(Map<String, dynamic> tag in user["tags"]){
      mockImprints.add(Imprintificator.instance.createImprint([(tag["id"] as int)], new GPS.withValues(0.0,0.0)));
    }
    UserPattern pattern = Patternificator.instance.createUserPatternFromImprints(mockImprints);
    patterns[user["id"]] = pattern;
  }

  Cachor.instance.userPatterns = patterns;
  Cachor.instance.eventImprints = JSON.decode(JSON.encode(imprints));

  //inits fittor including creation of default imprint and default pattern
  Fittor.instance;
}

List<Map<String,num>> getBestEventsFor(int userId, {int maxEventCount: 5}){
  Map<int, double> eventFitIndices = {};

  UserPattern pattern = Cachor.instance.userPatterns[userId];

  Cachor.instance.eventImprints.forEach((int eventId, Imprint imprint){
    eventFitIndices[eventId] = Fittor.instance.fitIndex(pattern, imprint).value;
  });

  List<int> eventIds = eventFitIndices.keys;
  eventIds.sort((a,b) => eventFitIndices[a].compareTo(eventFitIndices[b]));

  List<Map<String,num>> toReturn = [];
  for(int i=0;i< maxEventCount;i++){
    toReturn.add({"id": eventIds[i], "fitIndex": eventFitIndices[eventIds[i]]});
  }

  return toReturn;
}