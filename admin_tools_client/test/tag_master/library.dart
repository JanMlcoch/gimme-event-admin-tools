library test.tagMaster2;

import 'package:test/test.dart';
import 'dart:async';
import '../../lib/tag_master/repo/library.dart';
import '../../lib/tag_master/relation/library.dart';
import '../../lib/tag_master/tag.dart';
import '../../lib/tag_master/sidos_entities/library.dart';
import '../../lib/tag_master/library.dart';
import '../../lib/tag_master/smart_select/library.dart';

part 'repo_record_application.dart';
part 'repo_diff.dart';
part 'repo_lowest_free_id.dart';
part 'repo_validation/data.dart';
part 'repo_validation/repo_validation_local_validation.dart';
part 'repo_validation/repo_validation_synonym_relations_tags_types.dart';
part 'repo_validation/repo_validation_synonyms_have_relations.dart';
part 'repo_validation/repo_validation_customs.dart';
part 'repo_validation/repo_validation_unique_tag_ids.dart';
part 'repo_validation/repo_validation_unique_tag_names.dart';
part 'repo_validation/repo_validation_unique_relations.dart';
part 'repo_validation/repo_validation_relation_tags_exists.dart';
part 'smart_select/starts_with.dart';
part 'smart_select/substring.dart';
part 'smart_select/desired_count.dart';
part 'smart_select/allowed_types.dart';
part 'smart_select/synonym_remap.dart';
part 'smart_select/unicity.dart';
part 'smart_select/order.dart';

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
  group("Smart select tests", () {
    group("Smart select sorter tests", () {
      group("SMart select startsWithfiltering tests", sSStartsWithTests);
      group("Smart select substring filter tests", sSSubstringTests);
      //todo: startsWithAbbrev tests
      //todo: abbrev tests
      group("Allowed types tests", sSAllowedTypeTests);
      group("Handling size of output filter tests", desiredCountTest);
      group("Synonym remaping test", sSReMapSynonymsTests);
      group("Order tests", sSOrderTests);
      group("Tests of unicity of 'getTags()'", sSUnicityTests);
      //todo: excludeIds tests
    });
    //todo: index tests
    //todo: index generator tests
  });
//  group("TagMaster Repository tests", () {
//    group("TagMaster Repository Record Application tests", () {
//      group("Action record application tests", actionRecordApplicationTests);
//      group("Tag Master diff tests", repoDiffTests);
//    });
//    group("Tag Master getLowestUnusedId test", tagMasterRepoLowestUnusedIdTests);
//    group("TagMaster Repository validation tests", () {
//      group("TagMaster Repository local validation tests", tagMasterRepoLocalValidationTests);
//      group("Synonym Relations have appropriate tags and tag types tests",
//          synonymRelationsHaveAppropriateTagsAndTagTypesTests);
//      group("Synonyms have Appropriate relations tests", synonymsHaveRelationsTests);
//      group("TagMaster Repository validation customs tests", tagMasterRepoCustomValidationTests);
//      group("Unique tag ids tests", uniqueTagIdsTests);
//      group("Unique tag names tests", uniqueTagNamesTests);
//      group("Unique relation tests", uniqueRelationsTests);
//      group("Relation tags exists tests", relationTagsExistsTests);
//      //todo: custom having relations - in default redundant
//      //todo: composite having relations
//      //todo: specific having relations
//      //todo: core having relations
//      //todo: composite relations tags&types
//      //todo: imprint relations tags&types
//      //todo: setish originTagIds
//    });
//    //todo: getTagById test
//    //todo: getRelationsRelevant FOr ID test
//  });
}
