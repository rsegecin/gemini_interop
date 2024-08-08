import 'package:flutter/services.dart';
import 'package:gemini_interop/common/utils.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gemini_service.g.dart';

@Riverpod(dependencies: [])
class GeminiService extends _$GeminiService {
  // ignore: avoid_public_notifier_properties
  late GenerativeModel generativeModel;

  @override
  Future<bool> build() async {
    var apiKey = Utils.getApiKey();

    if (apiKey != "") {
      String promptPreamble = "";

      promptPreamble =
          await rootBundle.loadString('assets/gemini/instructions.txt');

      generativeModel = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        systemInstruction: Content.text(promptPreamble),
      );

      generativeModel.startChat();

      return true;
    }

    return false;
  }

  Future<String> generateContent(String content) async {
    final messageSent = content.trim();
    final response =
        await generativeModel.generateContent([Content.text(messageSent)]);
    return response.text?.trim() ?? "";
  }
}
