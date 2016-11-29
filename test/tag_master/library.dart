library test.tagMaster2;

import 'package:test/test.dart';
import 'dart:async';
import '../../lib/tag_master/repo/library.dart';
import '../../lib/tag_master/relation/library.dart';
import '../../lib/tag_master/tag.dart';
import '../../lib/tag_master/sidos_entities/library.dart';
import '../../lib/tag_master/library.dart';


part 'repo_record_application.dart';
part 'repo_validation/data.dart';
part 'repo_validation/repo_validation_local_validation.dart';
part 'repo_validation/repo_validation_synonym_relations_tags_types.dart';
part 'repo_validation/repo_validation_synonyms_have_relations.dart';
part 'repo_validation/repo_validation_customs.dart';
part 'repo_validation/repo_validation_unique_tag_ids.dart';
part 'repo_validation/repo_validation_unique_tag_names.dart';
part 'repo_validation/repo_validation_unique_relations.dart';
part 'repo_validation/repo_validation_relation_tags_exists.dart';

Future main() async {
  Timer timeout;
  setUp(() {
// fail the test after Duration
    timeout = new Timer(new Duration(seconds: 2), () => fail("timed out"));
  });
  tearDown(() {
// if the test already ended, cancel the timeout
    timeout.cancel();
  });
  group("TagMaster Repository tests", () {
    group("TagMaster Repository Record Application tests",(){
      actionRecordApplicationTests();
    });
    group("TagMaster Repository validation tests", () {
      group("TagMaster Repository local validation tests", () {
        tagMasterRepoLocalValidationTests();
      });
      group("Synonym Relations have appropriate tags and tag types tests", () {
        synonymRelationsHaveAppropriateTagsAndTagTypesTests();
      });
      group("Synonyms have Appropriate relations tests", () {
        synonymsHaveRelationsTests();
      });
      group("TagMaster Repository validation customs tests", () {
        tagMasterRepoCustomValidationTests();
      });
      group("Unique tag ids tests",(){
        uniqueTagIdsTests();
      });
      group("Unique tag names tests",(){
        uniqueTagNamesTests();
      });
      group("Unique relation tests",(){
        uniqueRelationsTests();
      });
      group("Relation tags exists tests",(){
        relationTagsExistsTests();
      });
      //todo: custom having relations - in default redundant
      //todo: composite having relations
      //todo: specific having relations
      //todo: core having relations
      //todo: composite relations tags&types
      //todo: imprint relations tags&types
    });
  });
}
