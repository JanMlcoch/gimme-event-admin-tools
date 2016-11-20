library test.tagMaster2;

import 'package:test/test.dart';
import 'dart:async';
import '../../lib/tag_master/library.dart';
import '../../lib/tag_master/repo/library.dart';
import '../../lib/tag_master/relation/library.dart';
import '../../lib/tag_master/tag.dart';
import '../../lib/tag_master/sidos_entities/library.dart';


part 'data.dart';
part 'repo_validation_base.dart';
part 'repo_validation_synonyms.dart';

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
    group("TagMaster Repository validation tests", () {
      group("TagMaster Repository validation basic tests", () {
        tagMasterRepoBasicValidationTests();
      });
      group("TagMaster Repository validation synonyms test", () {
        tagMasterRepoSynonymValidationTests();
      });
    });
  });
}
