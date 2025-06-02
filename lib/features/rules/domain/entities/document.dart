class DocumentParser {
  static List<String> extractParagraphs(Map<String, dynamic> document) {
    final content = document['body']['content'] as List;
    final paragraphs = <String>[];

    for (var element in content) {
      if (element.containsKey('paragraph')) {
        final paragraph = element['paragraph'];
        final textRuns = paragraph['elements'] as List;

        for (var run in textRuns) {
          if (run.containsKey('textRun')) {
            paragraphs.add(run['textRun']['content']);
          }
        }
      }
    }

    return paragraphs;
  }

  static String? extractImage(Map<String, dynamic> document) {
    final content = document['body']['content'] as List;

    for (var element in content) {
      if (element.containsKey('inlineObjectElement')) {
        final objectId = element['inlineObjectElement']['inlineObjectId'];
        final inlineObject = document['inlineObjects'][objectId];
        final embeddedObject =
        inlineObject['inlineObjectProperties']['embeddedObject'];
        return embeddedObject['imageProperties']['contentUri'];
      }
    }

    return null;
  }
}