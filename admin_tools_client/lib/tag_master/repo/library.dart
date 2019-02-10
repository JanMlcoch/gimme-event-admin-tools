///Library concentrating on [TagMasterRepository]
library tag_master_2.repo;

import 'dart:math';
import 'package:admin_tools/tag_master/tag.dart';
import 'package:admin_tools/tag_master/relation/library.dart';

part "repository_validator.dart";
part "tag_master_repo.dart";
part "validation_rule.dart";
part "rules/unique_tag_ids.dart";
part "rules/unique_tag_names.dart";
part "rules/unique_relations.dart";
part "rules/multirelations_have_nonrepeating_origins.dart";
part "rules/relation_tags_exists.dart";
part "rules/synonyms_have_appropriate_relations.dart";
part "rules/custom_tags_have_appropriate_relations.dart";
part "rules/composite_tags_have_appropriate_relations.dart";
part "rules/specific_tags_have_appropriate_relations.dart";
part "rules/core_tags_have_appropriate_relations.dart";
part "rules/synonym_relations_tags_and_types.dart";
part "rules/composite_relations_tags_and_types.dart";
part "rules/imprint_relations_tags_and_types.dart";

typedef bool RelationTest(Relation r);
typedef bool RepoTest(TagMasterRepository repo);