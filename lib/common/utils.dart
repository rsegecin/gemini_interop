import 'dart:io';

class Utils {
  static String convertFileName(String input) {
    // Replace "Controller" with "repository"
    String withoutController = input.replaceAll('Controller', 'Repository');

    // Convert CamelCase to snake_case
    String snakeCase = withoutController
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
            (Match match) => '${match.group(1)}_${match.group(2)}')
        .toLowerCase();

    // Replace ".cs" with ".dart"
    String finalResult = snakeCase.replaceAll('.cs', '.dart');

    return finalResult;
  }

  static String generateFileName(File file) {
    List<String> pathSegments = file.uri.pathSegments.toList();

    pathSegments[pathSegments.length - 1] =
        convertFileName(file.uri.pathSegments.last);

    Uri newUri = Uri(pathSegments: pathSegments);

    return Uri.decodeComponent(newUri.toString());
  }
}
