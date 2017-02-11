library tag_master_repository_getter;

import 'dart:async';
import 'dart:convert';
import 'package:admin_tools/tag_master/library.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
//import 'package:admin_tools/tag_master/server_gateway/requests.dart' as gw;

part 'connector.dart';

class TagMasterGetterGateway {
  static String accessToken;
  static String dataFromResponse;
  static DateTime lastLogin;
}

Future main()async{
  String repoString;
  getRepo().then((r){
    repoString = JSON.encode(r.toMap());
    Map repoMap = JSON.decode(repoString);
    TagMasterRepository repo = new TagMasterRepository()..fromMap(repoMap as Map<String, List<Map<String, dynamic>>>);
    Map mapie = repo.toMap();
    String deserializedJson = JSON.encode(mapie);
    deserializedJson = "Map a =$deserializedJson;";

    File tagMasterImport = new File("tag_master_import_map.dart");
    tagMasterImport.createSync();
    tagMasterImport.writeAsStringSync(deserializedJson);
  });
}
