import 'package:angular2/core.dart';

import 'dart:async';

import 'package:admin_tools/tag_master/library.dart';
import 'package:admin_tools/tag_master/repo_refactor/new_deserialized.dart';


@Injectable()
class GetRepoService {
  //todo: komunikace se serverem
  //todo: repo caching?
  TagMasterRepository _originRepo;
  TagMasterRepository _workingRepo;


  Future<Null> getTagMasterRepoFromRemote()async{
    Map<String, List<Map<String, dynamic>>> repoMap = {"tags":[],"relations":[]};
    if(a is Map<String, List<Map<String, dynamic>>>){
      repoMap = a as Map<String, List<Map<String, dynamic>>>;
    }
    else{
      throw new Exception("Repo has bad format");
    }
    _originRepo = new TagMasterRepository()..fromMap(repoMap);
    _workingRepo = new TagMasterRepository()..fromMap(repoMap);
  }

  Future<TagMasterRepository> getRepo() async{
    if(_originRepo == null || _workingRepo == null){
      await getTagMasterRepoFromRemote();
    }
    return _workingRepo;
  }

  Future<TagMasterRepository> getSubRepoOfTagId(int tagId) async{
    TagMasterRepository repo = await getRepo();
    Tag tag = repo.getTagById(tagId);
    TagMasterRepository subRepo = new TagMasterRepository.withData([tag],repo.getRelationsRelevantFor(tag));
    return subRepo;
  }
}