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
          if (run.containsKey('inlineObjectElement')) {
            final inlineObjectId = run['inlineObjectElement']['inlineObjectId'];
            final image = extractImage(document, inlineObjectId);
            if (image?.isNotEmpty ?? false) {
              paragraphs.add(image!);
            }
          }
        }
      }
    }

    return paragraphs;
  }

  static String? extractImage(Map<String, dynamic> document, String key) {
    try {
      final inlineObject = document['inlineObjects'][key];

      final embeddedObject =
          inlineObject['inlineObjectProperties']['embeddedObject'];
      final imageUri = embeddedObject['imageProperties']['contentUri'];
      return '<image>$imageUri<image>';
    } catch (e) {
      return null;
    }
  }
}
