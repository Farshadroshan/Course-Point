// import 'package:flutter/material.dart';
// import 'package:coursepoint/database/model/chat_message.dart';
// import 'package:coursepoint/services/api_service.dart';

// class ChatController {
//   final ChatService _chatService;
//   final String userId;
//   final ScrollController scrollController;
//   final Function(List<ChatMessage>) updateMessages;
//   final Function(bool) setTypingStatus;
//   final Function(String) showError;
//   final Function() checkMounted;
  
//   List<ChatMessage> messages = [];
//   bool isSending = false;

//   ChatController({
//     required ChatService chatService,
//     required this.userId,
//     required this.scrollController,
//     required this.updateMessages,
//     required this.setTypingStatus,
//     required this.showError,
//     required this.checkMounted,
//   }) : _chatService = chatService;

//   void loadChatHistory() {
//     List<ChatMessage> history = _chatService.getChatHistory(userId);
//     messages = history;
//     updateMessages(messages);
//     scrollToBottom();
//   }

//   void scrollToBottom() {
//     // Scroll to bottom of list view after rendering
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (scrollController.hasClients) {
//         scrollController.animateTo(
//           scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> sendMessage(String messageText) async {
//     if (messageText.isEmpty || isSending) return;

//     // Set flag to prevent double sending
//     isSending = true;
    
//     String userMessage = messageText.trim();

//     try {
//       // Add user message to UI
//       messages.add(ChatMessage(role: "user", text: userMessage));
//       updateMessages(List.from(messages));
      
//       scrollToBottom();

//       // Save to database
//       _chatService.saveMessage(userId, "user", userMessage);

//       // Show typing indicator
//       setTypingStatus(true);

//       // Fetch bot response
//       String botResponse = await _chatService.fetchBotResponse(userId, userMessage);

//       // Check if component is still mounted before updating state
//       if (checkMounted()) {
//         setTypingStatus(false);
//         messages.add(ChatMessage(role: "bot", text: botResponse));
//         updateMessages(List.from(messages));
        
//         scrollToBottom();
//       }

//       // Save bot response to database
//       _chatService.saveMessage(userId, "bot", botResponse);
//     } catch (e) {
//       print("Error sending message: $e");
      
//       if (checkMounted()) {
//         showError("Couldn't send message. Please try again.");
//       }
//     } finally {
//       // Reset sending flag
//       isSending = false;
//     }
//   }

//   void clearChat() {
//     messages.clear();
//     updateMessages(messages);
//     _chatService.clearChatHistory(userId);
//   }
// }



import 'package:flutter/material.dart';
import 'package:coursepoint/database/model/chat_message.dart';
import 'package:coursepoint/services/api_service.dart';

class ChatController {
  final ChatService _chatService;
  final String userId;
  final ScrollController scrollController;
  final Function(List<ChatMessage>) updateMessages;
  final Function(bool) setTypingStatus;
  final Function(String) showError;
  final Function() checkMounted;
  
  List<ChatMessage> messages = [];
  bool isSending = false;

  ChatController({
    required ChatService chatService,
    required this.userId,
    required this.scrollController,
    required this.updateMessages,
    required this.setTypingStatus,
    required this.showError,
    required this.checkMounted,
  }) : _chatService = chatService;

  void loadChatHistory() {
    List<ChatMessage> history = _chatService.getChatHistory(userId);
    messages = history;
    updateMessages(messages);
    scrollToBottom();
  }

  void scrollToBottom() {
    // Scroll to bottom of list view after rendering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage(String messageText) async {
    if (messageText.isEmpty || isSending) return;

    // Set flag to prevent double sending
    isSending = true;
    
    String userMessage = messageText.trim();

    try {
      // Add user message to UI
      messages.add(ChatMessage(role: "user", text: userMessage));
      updateMessages(List.from(messages));
      
      scrollToBottom();

      // Save to database
      _chatService.saveMessage(userId, "user", userMessage);

      // Show typing indicator
      setTypingStatus(true);

      // Fetch bot response
      String botResponse = await _chatService.fetchBotResponse(userId, userMessage);

      // Check if component is still mounted before updating state
      if (checkMounted()) {
        setTypingStatus(false);
        messages.add(ChatMessage(role: "bot", text: botResponse));
        updateMessages(List.from(messages));
        
        scrollToBottom();
      }

      // Save bot response to database
      _chatService.saveMessage(userId, "bot", botResponse);
    } catch (e) {
      print("Error sending message: $e");
      
      if (checkMounted()) {
        showError("Couldn't send message. Please try again.");
      }
    } finally {
      // Reset sending flag
      isSending = false;
    }
  }

  void clearChat() {
    messages.clear();
    updateMessages(messages);
    _chatService.clearChatHistory(userId);
  }
}