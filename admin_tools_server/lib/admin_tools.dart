library admin_tools.model;

import 'dart:convert';
import 'package:aqueduct/aqueduct.dart';

part 'model/user.dart';
part 'model/token.dart';
part 'model/tag_master/repo_version.dart';
part 'model/tagger/tagged_event.dart';

// Only for convenient migrations - without the need for
// $ aqueduct db generate -l "server/model/library"

void main() {
  throw "Do not use this!!!";
}
