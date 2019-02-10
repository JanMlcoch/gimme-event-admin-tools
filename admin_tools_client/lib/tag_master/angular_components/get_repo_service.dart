import 'dart:async';

import 'package:angular2/core.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:admin_tools/tag_master/repo_refactor/new_deserialized.dart';
import 'package:admin_tools/tag_master/server_gateway/requests.dart' as gw;

@Injectable()
class GetRepoService {
  static String loginToken;
  //todo: komunikace se serverem
  //todo: repo caching?
  TagMasterRepository _originRepo;
  TagMasterRepository _workingRepo;
  int originRepoId;

  Future<TagMasterRepository> gettingRepoFuture;

//  Future<Null> getTagMasterRepoFromRemoteOld() async {
//    //todo: get from remote
//    Map<String, List<Map<String, dynamic>>> repoMap = {"tags": [], "relations": []};
//    if (a is Map<String, List<Map<String, dynamic>>>) {
//      repoMap = a as Map<String, List<Map<String, dynamic>>>;
//    } else {
//      throw new Exception("Repo has bad format");
//    }
//    _originRepo = new TagMasterRepository()..fromMap(repoMap);
//    _workingRepo = new TagMasterRepository()..fromMap(repoMap);
//  }

  Future<Null> getTagMasterRepoFromRemote() async {
    print("getting repo");
    //todo: get from remote
    Map<String, List<Map<String, dynamic>>> repoMap;
    Map response = await gw.getRepo();
    repoMap = (response["repo"] as TagMasterRepository).toMap();
    originRepoId = response["repoId"];
    _originRepo = new TagMasterRepository()..fromMap(repoMap);
    _workingRepo = new TagMasterRepository()..fromMap(repoMap);
  }

  Future<TagMasterRepository> getWorkingRepo() {
    if(_workingRepo!=null){
      return new Future.value(_workingRepo);
    }

    if (gettingRepoFuture != null) {
      return gettingRepoFuture;
    }
    var onRepo = new Completer<TagMasterRepository>();
    gettingRepoFuture = onRepo.future;
    if (_originRepo == null || _workingRepo == null) {
      getTagMasterRepoFromRemote().then((_) {
        onRepo.complete(_workingRepo);
      });
    }
    return gettingRepoFuture;
  }

  TagMasterRepository revertChanges() {
    _workingRepo = _originRepo.copy();
    return _workingRepo;
  }

//  void saveChangesOld() {
//    //todo: kominukace se serverem
//    _originRepo = _workingRepo.copy();
//  }

  Future saveChanges() async {
    //todo: solve conflicts
    print("Saving changes");
    print(_workingRepo.copy().toMap().toString());

    int remoteRepoId = await gw.getRemoteLastRepoId();
    if (remoteRepoId == originRepoId) {
      print(_workingRepo.copy().toMap().toString());
      await gw.pushRepo(_workingRepo.copy(), originRepoId);
      await getTagMasterRepoFromRemote();
    } else {
      throw "Konflikt, kontaktuje šmóďu.";
    }
  }

  Future<TagMasterRepository> getSubRepoOfTagId(int tagId) async {
    TagMasterRepository repo = await getWorkingRepo();
    Tag tag = repo.getTagById(tagId);
    TagMasterRepository subRepo = new TagMasterRepository.withData([tag], repo.getRelationsRelevantFor(tag));
    return subRepo;
  }
}
