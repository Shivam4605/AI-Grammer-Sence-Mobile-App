import 'dart:convert';
import 'dart:developer';

import 'package:ai_grammer_app/models/ai_responce_model.dart';
import 'package:ai_grammer_app/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatController with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<ChatMessage> chatList = [];

  Future<String> postUserRequest({required String userInputText}) async {
    String baseUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent";

    String apiKey = dotenv.env['apiKey']!;

    String prompt =
        """
            You are a grammar checker.

            Rules:

            1. Ignore capitalization (uppercase/lowercase).

            2. Ignore punctuation if it is the only issue.

            3. If the sentence is grammatically correct, reply only with:
            Correct

            4. If the sentence is grammatically incorrect, reply only with the corrected sentence.

            Do not add explanations, punctuation, or any extra text.

            Sentence:
            $userInputText
""";

    chatList.add(
      ChatMessage(
        message: userInputText,
        isUser: true,
        isCorrectCheck: false,
        isLoading: true,
      ),
    );
    final int currentUserIndex = chatList.length - 1;

    _isLoading = true;
    notifyListeners();

    try {
      Uri uri = Uri.parse(baseUrl);

      Map<String, dynamic> json = {
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      };

      http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json', 'x-goog-api-key': apiKey},
        body: jsonEncode(json),
      );

      notifyListeners();

      if (response.statusCode == 429) {
        chatList.add(
          ChatMessage(
            message:
                "You've reached the request limit. Please wait 30 seconds and try again.",
            isUser: false,
            isCorrectCheck: false,
            isLoading: true,
          ),
        );
        notifyListeners();
      }

      if (response.statusCode == 503) {
        chatList.add(
          ChatMessage(
            message:
                "This model is currently experiencing high demand. Spikes in demand are usually temporary. Please try again later",
            isUser: false,
            isCorrectCheck: false,
            isLoading: true,
          ),
        );
        notifyListeners();
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);

        AiResponceModel aiResponceModel = AiResponceModel.fromJson(json);

        final aiText =
            aiResponceModel.candidates?.first.content?.partsList?.first.text ??
            "";

        String responseString = "";

        bool isCorrrectCheck = aiText.trim() == 'Correct';

        chatList[currentUserIndex].isLoading = false;
        chatList[currentUserIndex].isCorrectCheck = isCorrrectCheck;

        if (isCorrrectCheck) {
          responseString =
              "Your sentence “$userInputText” is already grammatically correct!";
        } else {
          responseString =
              "Your sentence has a small grammatical mistake. Here’s the corrected version: \n\n $aiText";
        }

        chatList.add(
          ChatMessage(
            message: responseString,
            isUser: false,
            isCorrectCheck: isCorrrectCheck,
            isLoading: false,
          ),
        );
        log("Response Is : ${response.body}");
        notifyListeners();

        log("API called Successfully");

        return responseString;
      }

      log("Response : ${response.body}");
      log("status Code : ${response.statusCode}");

      return "";
    } catch (e) {
      log("Error : $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return "";
  }

  void deleteConversation() {
    chatList.clear();
    notifyListeners();
  }
}
