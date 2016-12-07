part of tagMaster2.smartSelect;
//todo: docs
abstract class SmartSorter {
  static List<LabeledTag> getTags(String inputString, TagMasterRepository repo,
      {SmartIndex index: null,
      List<int> allowedTypes: const [1, 2, 3, 4, 5],
      bool shouldReMapSynonyms: true,
      bool giveMaximalAmount: false,
      int numberOfTagsDesired: 5,
      int indexNumberOfMatchedCharacters: 0}) {
    if (index != null) {
      String matchingString = inputString.substring(indexNumberOfMatchedCharacters);
      if (matchingString == "") {
        return getTags(inputString, new TagMasterRepository.withData(index.tags, []),
            index: null,
            allowedTypes: allowedTypes,
            shouldReMapSynonyms: shouldReMapSynonyms,
            numberOfTagsDesired: numberOfTagsDesired,
            giveMaximalAmount: giveMaximalAmount,
            indexNumberOfMatchedCharacters: indexNumberOfMatchedCharacters);
      }
      List<LabeledTag> toReturn;
      index.tree.forEach((String key, SmartIndex subIndex) {
        if (matchingString.startsWith(key)) {
          toReturn = getTags(inputString, repo,
              index: subIndex,
              allowedTypes: allowedTypes,
              shouldReMapSynonyms: shouldReMapSynonyms,
              numberOfTagsDesired: numberOfTagsDesired,
              giveMaximalAmount: giveMaximalAmount,
              indexNumberOfMatchedCharacters: indexNumberOfMatchedCharacters + 1);
        }
      });
      if (toReturn != null) {
        return toReturn;
      } else {
        return getTags(inputString, new TagMasterRepository.withData(index.tags, []),
            index: null,
            allowedTypes: allowedTypes,
            shouldReMapSynonyms: shouldReMapSynonyms,
            numberOfTagsDesired: numberOfTagsDesired,
            giveMaximalAmount: giveMaximalAmount,
            indexNumberOfMatchedCharacters: indexNumberOfMatchedCharacters);
      }
    }
    //here begins own sorting and filtering
    List<Tag> tagsStartsWith = getStartsWithTags(repo,inputString);
    List<Tag> tagsSubstring = getSubstringTags(repo,inputString);;
    List<Tag> tagsAbbreviationStartsWith = getStartsWithAbbrevTags(repo,inputString);;
    List<Tag> tagsAbbreviation = getAbbrevTags(repo,inputString);;

    TagCompare tagTypeCompare = (a, b) => -a.tagType.compareTo(b.tagType);

    tagsStartsWith.sort(tagTypeCompare);
    tagsSubstring.sort(tagTypeCompare);
    tagsAbbreviationStartsWith.sort(tagTypeCompare);
    tagsAbbreviation.sort(tagTypeCompare);

    //todo: future optimalization
    if (false /*giveMaximalAmount*/) {
      //todo: implement
    } else {
      int procedure(List<LabeledTag> sorted, Tag tag, int i) {
        if (allowedTypes.contains(tag.tagType)) {
          if (shouldReMapSynonyms && tag.tagType == Tag.TYPE_SYNONYM) {
            tag = new LabeledTag.fromTag(
                "${tag.tagName} -->", repo.getTagById(repo.getRelationsRelevantFor(tag).first.destinationTagId));
          }
          if(!(tag is LabeledTag))tag = new LabeledTag.fromTag("",tag);
          //todo: find out why strong mode havent shouted if tag in next row wasnt sure to be LabeledTag
          if (sorted.where((tag2) => tag2.tagId == tag.tagId).isEmpty) sorted.add(tag);
        }
        return i + 1;
      }

      List<LabeledTag> toReturn = [];
      int i = 0;
      while ((toReturn.length < numberOfTagsDesired || giveMaximalAmount) && i < tagsStartsWith.length)
        i = procedure(toReturn, tagsStartsWith[i], i);
      i = 0;
      while ((toReturn.length < numberOfTagsDesired || giveMaximalAmount) && i < tagsSubstring.length)
        i = procedure(toReturn, tagsSubstring[i], i);
      i = 0;
      while ((toReturn.length < numberOfTagsDesired || giveMaximalAmount) && i < tagsAbbreviationStartsWith.length)
        i = procedure(toReturn, tagsAbbreviationStartsWith[i], i);
      i = 0;
      while ((toReturn.length < numberOfTagsDesired || giveMaximalAmount) && i < tagsAbbreviation.length)
        i = procedure(toReturn, tagsAbbreviation[i], i);
      return toReturn;
    }
  }

  static List<Tag> getStartsWithTags(TagMasterRepository repo, String string){
    List<Tag> toReturn = [];
    for(Tag tag in repo.tags){
      if(tag.tagName.toLowerCase().startsWith(string.toLowerCase()))toReturn.add(tag);
    }
    return toReturn;
  }

  static List<Tag> getSubstringTags(TagMasterRepository repo, String string){
    List<Tag> toReturn = [];
    for(Tag tag in repo.tags){
      if(tag.tagName.toLowerCase().contains(string.toLowerCase()))toReturn.add(tag);
    }
    return toReturn;
  }

  //todo: implement
  static List<Tag> getStartsWithAbbrevTags(TagMasterRepository repo, String string){
    return [];
  }

  //todo: implement
  static List<Tag> getAbbrevTags(TagMasterRepository repo, String string){
    return [];
  }

  //todo: method for boldification
}
