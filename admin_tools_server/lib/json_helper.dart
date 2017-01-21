library json_helper;

import 'dart:convert';

class JsonHelper{
  static Map<String, dynamic> decodeMap(String source) {
    dynamic decoded = JSON.decode(source);
    if (decoded is Map<String, dynamic>) return decoded;
    return null;
  }

  static List<Map<String, dynamic>> decodeListOfMaps(String source) {
    dynamic decoded = JSON.decode(source);
    if (decoded is List<Map<String, dynamic>>) return decoded;
    return null;
  }

  static List<dynamic> decodeList(String source) {
    dynamic decoded = JSON.decode(source);
    if (decoded is List<dynamic>) return decoded;
    return null;
  }

  static String encodeMap(Map<String, dynamic> map) => JSON.encode(map);

  static String encodeList(List<dynamic> list) => JSON.encode(list);

  static String encode(Object any) => JSON.encode(any);
}

