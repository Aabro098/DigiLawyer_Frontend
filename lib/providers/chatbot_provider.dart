import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:digi_lawyer/controller/chatbot_controller.dart';
import 'package:digi_lawyer/model/chatbot_message_model.dart';

class ChatbotProvider with ChangeNotifier {
  final List<ChatbotMessageModel> _messages = [];
  List<ChatbotMessageModel> get messages => List.unmodifiable(_messages);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set loading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getMessages({required String query}) async {
    loading = true;
    try {
      await addMessage(query, true);
      final response =
          await ChatbotController.instance.getResponse(query: query);
      final chatbotResponse =
          response['response'] ?? 'No response from the chatbot.';
      await addMessage(
        chatbotResponse,
        false,
      );
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
    }
  }

  Future<void> clearMessages() async {
    _messages.clear();
    notifyListeners();
  }

  Future<void> addMessage(String message, bool isSentByMe) async {
    _messages.add(
      ChatbotMessageModel(message: message, isSentByMe: isSentByMe),
    );
    notifyListeners();
  }
}
