import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:async';
import 'package:angular2/router.dart';
import 'ss_component.dart';

@Component(
    selector: "edit-tag",
    templateUrl: 'edit_tag_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES, SmartSelectComponent],
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
      subRepo.relations.where((Relation relation) => relation.originTagIds.single == tagId).toList();

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
      if (repo.getTagById(relation.destinationTagId).tagType > 3) {
        relationsToAdd.add(new Relation.composite(
            relation.originTagIds, relation.destinationTagId, relation.getRepresentativeStrength()));
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
      if (repo.getTagById(relation.destinationTagId).tagType == Tag.TYPE_CORE) {
        if (tag.tagType == Tag.TYPE_CORE) {
          relationsToAdd.add(relation);
        } else {
          if (repo.getTagById(relation.destinationTagId).tagType == Tag.TYPE_CORE) {
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
      if (repo.getTagById(relation.destinationTagId).tagType == Tag.TYPE_CORE) {
        if (tag.tagType == Tag.TYPE_SPECIFIC) {
          relationsToAdd.add(relation);
        } else {
          if (repo.getTagById(relation.destinationTagId).tagType == Tag.TYPE_CORE) {
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
      //todo: more robust
      relation = new Relation.imprintDefault([tagId], -1);
    }
    subRepo.relations.add(relation);
    repo.relations.add(relation);
  }

  void removeRelation(Relation relation) {
    subRepo.relations.remove(relation);
    repo.relations.remove(relation);
    //todo: global/toCommit removal
  }

  void editRelation(Relation relation) {
    relationToEdit = relation;
  }

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
