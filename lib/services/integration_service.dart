// ignore_for_file: avoid_print

import 'dart:io';

import 'package:gemini_interop/common/utils.dart';
import 'package:gemini_interop/services/gemini_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:file_picker/file_picker.dart';

part 'integration_service.g.dart';

@riverpod
class IntegrationService extends _$IntegrationService {
  @override
  build() {
    ref.watch(geminiServiceProvider);
    return null;
  }

  Future<String> convertFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if ((result != null) && result.files.isNotEmpty) {
      String fileString = await result.xFiles[0].readAsString();
      return ref
          .read(geminiServiceProvider.notifier)
          .generateContent(fileString);
    }

    return "";
  }

  Future<String> generateMultipleFiles() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      final directory = Directory(directoryPath);
      if (directory.existsSync()) {
        List<File> files = [];
        // List all files and directories
        directory.listSync().forEach((FileSystemEntity file) async {
          if ((file is File) && file.uri.pathSegments.last.endsWith(".cs")) {
            files.add(file);
          }
        });

        final futures = files.map((file) => generateFile(file)).toList();
        await Future.wait(futures);
      }
    }

    return "";
  }

  Future generateFile(File refFile) async {
    final generatedFilePath = Utils.generateFileName(refFile);
    var file = File(generatedFilePath);

    await file.create(recursive: true);

    String fileString = await refFile.readAsString();
    final content = await ref
        .read(geminiServiceProvider.notifier)
        .generateContent(fileString);

    file.writeAsString(content);
  }
}
