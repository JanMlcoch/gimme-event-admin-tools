///This library handles "back-end-ish" functionality of Smart Select (for [Tag]s)
library tagMaster2.smartSelect;

import '../tag.dart';
import '../repo/library.dart';

part 'smart_sorter.dart';
part 'smart_index.dart';
part 'labeled_tag.dart';

typedef int TagCompare(Tag a, Tag b);