import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:admin_tools/tag_master/angular_components/get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:admin_tools/tag_master/angular_components/smart-select.dart';
import 'package:admin_tools/tag_master/angular_components/material_number/material_number.dart';

@Component(
    selector: "edit-tag",
    templateUrl: 'edit_tag_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES, SmartSelectComponent, MaterialNumberComponent],
    providers: const [materialProviders])
class EditTagComponent implements OnInit {
  final GetRepoService _repoService;
  final RouteParams _routeParams;
  EditTagComponent(this._repoService, this._routeParams);
  int get tagId => subRepo.tags.first.tagId;
  Tag get tag => subRepo.tags.first;

  @Input()
  TagMasterRepository subRepo;
  TagMasterRepository repo;

  List<Relation> get relationsFrom =>
      subRepo.relations.where((Relation relation) => relation.originTagIds.contains(tagId)).toList();

  List<Relation> get relationsTo =>
      subRepo.relations.where((Relation relation) => relation.destinationTagId == tagId).toList();

  Relation relationToEdit;

  Future<Null> changeToCustom() async {
    //todo: kecy o nebezpečnosti
    //todo: check influence on validity
    List<Relation> relations = repo.getRelationsRelevantFor(tag);
    for (Relation relation in relations) {
      repo.relations.remove(relation);
    }
    subRepo.tags.first.tagType = Tag.TYPE_CUSTOM;
    subRepo = await _repoService.getSubRepoOfTagId(tagId);
  }

  Future<Null> changeToSynonym() async {
    //todo: kecy o nebezpečnosti
    //todo: check influence on validity
    List<Relation> relations = repo.getRelationsRelevantFor(tag);
    for (Relation relation in relations) {
      //todo: keep representative relation?
      repo.relations.remove(relation);
//      if(relation.destinationTagId==tagId)repo.relations.remove(relation);
//      if(relation.originTagIds.length!=1)repo.relations.remove(relation);
    }
    subRepo.tags.first.tagType = Tag.TYPE_SYNONYM;
    subRepo = await _repoService.getSubRepoOfTagId(tagId);
  }

//todo: tests of change functions
  Future<Null> changeToComposite() async {
    List<Relation> relationsToAdd = [];

    for (Relation relation in relationsFrom) {
      if(repo.getTagById(relation.destinationTagId) == null)continue;
      if (repo.getTagById(relation.destinationTagId).tagType > 3) {
        //todo: comment or redo multi relation reduction
        relationsToAdd.add(new Relation.composite(
            [relation.originTagIds.first], relation.destinationTagId, relation.getRepresentativeStrength()));
      }
    }

    for (Relation relation in relationsTo) {
      if (relation.type == RelationSubstance.SYNONYM) relationsToAdd.add(relation);
    }

    for (Relation relation in repo.getRelationsRelevantFor(tag)) {
      repo.relations.remove(relation);
    }
    for (Relation relation in relationsToAdd) {
      repo.relations.add(relation);
    }

    subRepo.tags.first.tagType = Tag.TYPE_COMPOSITE;
    subRepo = await _repoService.getSubRepoOfTagId(tagId);
  }

  Future<Null> changeToSpecific() async {
    List<Relation> relationsToAdd = [];

    for (Relation relation in relationsFrom) {
      if (repo.getTagById(relation.destinationTagId)?.tagType == Tag.TYPE_CORE) {
        if (tag.tagType == Tag.TYPE_CORE) {
          relationsToAdd.add(relation);
        } else {
          if (repo.getTagById(relation.destinationTagId)?.tagType == Tag.TYPE_CORE) {
            relationsToAdd.add(new Relation.imprintFromValue(
                relation.originTagIds, relation.destinationTagId, relation.getRepresentativeStrength()));
          }
        }
      }
    }
    for (Relation relation in relationsTo) {
      if (relation.type == RelationSubstance.SYNONYM || relation.type == RelationSubstance.COMPOSITE) {
        relationsToAdd.add(relation);
      }
    }

    for (Relation relation in repo.getRelationsRelevantFor(tag)) {
      repo.relations.remove(relation);
    }
    for (Relation relation in relationsToAdd) {
      repo.relations.add(relation);
    }

    subRepo.tags.first.tagType = Tag.TYPE_SPECIFIC;
    subRepo = await _repoService.getSubRepoOfTagId(tagId);
  }

  Future<Null> changeToCore() async {
    List<Relation> relationsToAdd = [];

    for (Relation relation in relationsFrom) {
      if (repo.getTagById(relation.destinationTagId)?.tagType == Tag.TYPE_CORE) {
        if (tag.tagType == Tag.TYPE_SPECIFIC) {
          relationsToAdd.add(relation);
        } else {
          if (repo.getTagById(relation.destinationTagId)?.tagType == Tag.TYPE_CORE) {
            relationsToAdd.add(new Relation.imprintFromValue(
                relation.originTagIds, relation.destinationTagId, relation.getRepresentativeStrength()));
          }
        }
      }
    }
    for (Relation relation in relationsTo) {
      relationsToAdd.add(relation);
    }

    for (Relation relation in repo.getRelationsRelevantFor(tag)) {
      repo.relations.remove(relation);
    }
    for (Relation relation in relationsToAdd) {
      repo.relations.add(relation);
    }

    subRepo.tags.first.tagType = Tag.TYPE_CORE;
    subRepo = await _repoService.getSubRepoOfTagId(tagId);
  }

  List<int> getValidTargetTypes(int originType) {
    if (originType == Tag.TYPE_SYNONYM) return [2, 3, 4, 5];
    if (originType == Tag.TYPE_CUSTOM) return [];
    if (originType == Tag.TYPE_COMPOSITE) return [4, 5];
    if (originType == Tag.TYPE_SPECIFIC) return [5];
    if (originType == Tag.TYPE_CORE) return [5];
    return null;
  }

  bool addRelationEnabled() {
    if (tag.tagType == Tag.TYPE_CUSTOM) return false;
    if (tag.tagType == Tag.TYPE_SYNONYM && repo.getRelationsRelevantFor(tag).isNotEmpty) return false;
    return true;
  }

  void deleteTag() {
    //todo: kecy o nebezpečnosti
    //todo: check influence on validity
    repo.tags.remove(subRepo.tags.first);
    for (Relation relation in subRepo.relations) {
      repo.relations.remove(relation);
    }
  }

  void replaceOriginTagId(Relation relation, int oldId, int newId) {
    relation.originTagIds.remove(oldId);
    relation.originTagIds.add(newId);
  }

  //todo: discuss defaults
  void addRelationFrom() {
    int tagId = subRepo.tags.single.tagId;
    int type = subRepo.tags.single.tagType;
    Relation relation;
    if (type == Tag.TYPE_SYNONYM) {
      //todo: more robust
      relation = new Relation.synonym([tagId], -1);
    }
    if (type == Tag.TYPE_COMPOSITE) {
      //todo: more robust
      relation = new Relation.composite([tagId], -1, 0.5);
    }
    if (type == Tag.TYPE_SPECIFIC || type == Tag.TYPE_CORE) {
      //todo: more robust ?
      relation = new Relation.imprintFromValue([tagId], -1, 1.0);
    }
    subRepo.relations.add(relation);
    repo.relations.add(relation);
  }

  void addOriginTagId(Relation relation) {
    relation.originTagIds.add(-1);
  }

  void removeOriginTagId(Relation relation) {
    relation.originTagIds.removeLast();
  }

  void removeRelation(Relation relation) {
    subRepo.relations.remove(relation);
    repo.relations.remove(relation);
    //todo: global/toCommit removal
  }

  void editRelation(Relation relation) {
    relationToEdit = relation;
  }

  @override
  Future<Null> ngOnInit() async {
    String _tagIdString = _routeParams.get('id');
    _tagIdString = _tagIdString != null ? _tagIdString : "";
    int _tagId = int.parse(_tagIdString, onError: (_) {
      throw new Exception("Parsing of tagId from routing parameters failed");
    });
//    subRepo = await _repoService.getRepo();
    subRepo = await _repoService.getSubRepoOfTagId(_tagId);
    repo = await _repoService.getRepo();
  }
}
