import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

Map pages = {};
int fileWrites = 0;
Random random = new Random();

Map months = {
  "leden": 1,
  "únor": 2,
  "březen": 3,
  "duben": 4,
  "květen": 5,
  "červen": 6,
  "červenec": 7,
  "srpen": 8,
  "září": 9,
  "říjen": 10,
  "listopad": 11,
  "prosinec": 12
};


void main(List<String> args) {
  String url = "http://www.kudyznudy.cz/aktivity-a-akce/akce/zahajeni-farmarskych-trhu-na-kulataku-7-3-2015.aspx";
  downloadUrl(new Page()..url = url).then((BareEvent event) {
    print(JSON.encode(event.toMap()));
  });
  new Future.delayed(const Duration(seconds: 4)).then(tryDownload);
}

void tryDownload([_]) {
  for (String key in pages.keys) {
    Page page = pages[key];
    if (!page.isDownloaded && !page.isDownloading) {
      downloadUrl(page);
      break;
    }
  }
  new Future.delayed(new Duration(seconds: random.nextInt(5) + 1)).then(tryDownload);
}

Future<BareEvent> downloadUrl(Page page) async {
  page.isDownloading = true;
  String url = page.url;
  BareEvent event = new BareEvent();
  String data;
  try {
    data = await http.read(url);
  } catch (e) {
    return null;
  }
  page.content = data;
  page.isDownloading = false;
  page.isDownloaded = true;
  var document = new dom.Document.html(data);
  extractAnchors(document);
  event.name = document
      .querySelector(".detail h1")
      ?.innerHtml ?? "";
  var description = document
      .querySelector(".annotation")
      ?.innerHtml ?? "";
  if (description.length > 101) {
    description = description.substring(0, 100);
  }
  event.description = description;
  event.date = getDateTime(document);
  event.location = getLocation(document);
  event.dateString = document
      .querySelector(".date-info")
      ?.innerHtml ?? "";

//  months.forEach((k,v){
//    if(monthAndYear.contains(k)){
//      month = v;
//      String yrs = monthAndYear.replaceAll(k,"").replaceAll(" ","");
//      year = int.parse(yrs);
//    }
//  });
//
//  event.date = new DateTime(year, month, day);

  event.source = url;
  page.event = event;
  print("downloaded $url know address count ${pages.keys.length}");
  makeOutput();
  return event;
}

Map<String, double> getLocation(dom.Document document) {
  dom.Element element = document.querySelector("#szn-map");
  if (element == null) return null;
  if (element.attributes.containsKey("data-lat") && element.attributes.containsKey("data-lon")) {
    double lat = double.parse(element.attributes["data-lat"],(_)=>null);
    double lon = double.parse(element.attributes["data-lon"],(_)=>null);
    return <String, double>{"lat": lat, "lon": lon};
  }
  return null;
}

DateTime getDateTime(dom.Document document) {
  dom.Element dateInfo = document.querySelector(".date-info");
  if (dateInfo == null) {
    return null;
  }
  List<String> parts = dateInfo.text.split(" ");
  if (parts.length == 7) {
    int day = int.parse(parts[1].replaceAll(".", ""), onError: (_) => null);
    if (day == null) return null;
    int month;
    if (months.containsKey(parts[2])) {
      month = months[parts[2]];
    } else {
      return null;
    }
    int year = int.parse(parts[4], onError: (_) => null);
    if (year == null) return null;
    return new DateTime(year, month, day);
  }
  return null;
}

class BareEvent {
  String name;
  String source;
  String description;
  DateTime date;
  String dateString;
  List<String> tags = [];
  Map<String, double> location;

  bool isValid() {
    return description != null && description.length > 0 && location != null;
  }

  Map toMap() {
    Map out = {};
    out["name"] = name;
    out["description"] = description;
    out["source"] = source;
    out["date"] = date?.toIso8601String();
    out["dateString"] = dateString;
    out["location"] = location;
    return out;
  }
}

class Page {
  String content;
  BareEvent event;
  bool isDownloaded = false;
  bool isDownloading = false;
  String url;

  bool isValid() {
    return event != null && event.isValid();
  }

  Map toMap() {
    Map out = {};
//    out["content"] = content;
    out["event"] = event.toMap();
    out["url"] = url;
    return out;
  }
}

void extractAnchors(dom.Document document) {
  document.querySelectorAll("a").forEach((e) {
    if (e.attributes["href"] is String) {
      String relativePath = e.attributes["href"];
      if (!relativePath.startsWith("/") || relativePath.length < 2) return;
      String path = "http://www.kudyznudy.cz" + e.attributes["href"];
      Uri uri = Uri.parse(path);
      if (!pages.containsKey(path) && uri.isAbsolute) {
        pages[path] = new Page()
          ..url = path;
      }
    }
  });
}

void makeOutput() {
  if (fileWrites++ % 10 == 0) {
    File data = new File("data.json");
    data.writeAsString(JSON.encode(encodePages()));
  }
}

Map encodePages() {
  Map out = {};
  pages.forEach((k, Page v) {
    if (v.isDownloaded && v.isValid()) {
      out[k] = v.toMap();
    }
  });
  return out;
}