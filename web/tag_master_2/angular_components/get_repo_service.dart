import 'package:angular2/core.dart';

import 'dart:async';

import '../tag_master/library.dart';
import '../data/repo_refactor/new_deserialized.dart';

//class TagMasterRepository{
//  void fromMap(Map<String, List<Map<String, dynamic>>> b){}
//}
//
//Map a = {};

@Injectable()
class GetRepoService {
  //todo: komunikace se serverem
  Future<TagMasterRepository> getRepo() async{
    Map<String, List<Map<String, dynamic>>> repoMap = {};
    if(a is Map<String, List<Map<String, dynamic>>>){

    repoMap = a as Map<String, List<Map<String, dynamic>>>;
    }
    else{
      throw new Exception("Repo has bad format");
    }
    return new TagMasterRepository()..fromMap(repoMap);
  }
}