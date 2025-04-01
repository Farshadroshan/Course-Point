
import 'package:coursepoint/database/model/chat_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

  class ChatService {
  final Dio _dio = Dio();
  final Box chatBox = Hive.box('chats');

  // Add request tracking to prevent duplicate requests
  final Map<String, bool> _ongoingRequests = {};

  Future<String> fetchBotResponse(String userId, String message) async {
    // Create a unique key for this request
    String requestKey = "$userId:$message:${DateTime.now().millisecondsSinceEpoch}";
    
    // Check if this exact request is already in progress
    if (_ongoingRequests[requestKey] == true) {
      return "Processing...";
    }
    
    // Mark request as ongoing
    _ongoingRequests[requestKey] = true;
    
    try {
      String apiKey = dotenv.env["API_KEY"] ?? " ";

      if (apiKey.isEmpty) {
        print(" API Key is missing!");
        return "Error: API Key is missing.";
      }

      String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey";

      Response response = await _dio.post(
        apiUrl,
        data: {
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        return response.data['candidates'][0]['content']['parts'][0]['text'] ?? "No response from bot.";
      } else {
        return "Error: ${response.statusCode} - ${response.statusMessage}";
      }
    } catch (e) {
      print(" API Error: $e");
      return "Error: Unable to connect to chatbot.";
    } finally {
      // Remove request from tracking map
      _ongoingRequests.remove(requestKey);
    }
  }

  void saveMessage(String userId, String role, String text) {
    // Create a unique ID for each message to prevent duplicates
    String messageId = "${DateTime.now().millisecondsSinceEpoch}_$role";
    
    // Retrieve chat history for this user
    List<ChatMessage> chatHistory = chatBox.get(userId, defaultValue: []).cast<ChatMessage>();
    
    // Check if this exact message already exists (prevent duplicates)
    bool isDuplicate = chatHistory.any((msg) => 
      msg.role == role && msg.text == text && 
      DateTime.now().difference(msg.timestamp ?? DateTime.now()).inSeconds < 5
    );
    
    if (!isDuplicate) {
      // Add new message with timestamp
      chatHistory.add(ChatMessage(
        role: role, 
        text: text,
        timestamp: DateTime.now()
      ));
      
      // Save back to Hive
      chatBox.put(userId, chatHistory);
    }
  }

  List<ChatMessage> getChatHistory(String userId) {
    return chatBox.get(userId, defaultValue: []).cast<ChatMessage>();
  }

  // delete chat from the specific user 
  void clearChatHistory (String userId){
    chatBox.delete(userId);
  }

}