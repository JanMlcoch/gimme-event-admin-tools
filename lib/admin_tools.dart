library admin_tools.model;

import 'package:aqueduct/aqueduct.dart';

part 'server/model/user.dart';
part 'server/model/token.dart';
part 'server/model/tag_master/repo_action.dart';
part 'server/model/tag_master/repo_version.dart';
part 'server/model/tag_master/repository.dart';

// Only for convenient migrations - without the need for
// $ aqueduct db generate -l "server/model/library"

void main(){
  throw "Do not use this!!!";
}