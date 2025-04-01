import 'package:coursepoint/database/model/chat_message.dart';
import 'package:coursepoint/helpers/chat_controller.dart';
import 'package:coursepoint/services/api_service.dart';
import 'package:coursepoint/widget/apppcolor.dart';
import 'package:coursepoint/widget/chat_bot_menu_items.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
// Import the new controller
// import 'package:coursepoint/controllers/chat_controller.dart';

// Create a singleton pattern for ChatService to ensure only one instance exists
class ChatServiceSingleton {
  static final ChatServiceSingleton _instance = ChatServiceSingleton._internal();
  final ChatService chatService = ChatService();
  
  factory ChatServiceSingleton() {
    return _instance;
  }
  
  ChatServiceSingleton._internal();
}

class ChatScreen extends StatefulWidget {
  final String userId;

  ChatScreen({required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Use the singleton instance
  final ChatService _chatService = ChatServiceSingleton().chatService;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatController _chatController;
  List<ChatMessage> messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _chatController = ChatController(
      chatService: _chatService,
      userId: widget.userId,
      scrollController: _scrollController,
      updateMessages: (updatedMessages) {
        setState(() {
          messages = updatedMessages;
        });
      },
      setTypingStatus: (status) {
        setState(() {
          _isTyping = status;
        });
      },
      showError: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red.shade400,
          ),
        );
      },
      checkMounted: () => mounted,
    );
    
    _chatController.loadChatHistory();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    String text = _controller.text;
    _controller.clear();
    _chatController.sendMessage(text);
  }

  void _clearChat() {
    _chatController.clearChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.smart_toy, color: appBarColor, size: 20),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Assistant",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  _isTyping ? "Typing..." : "Online",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<ChatBotMenuItem>(
           onSelected: (value) {
             if(value == ChatBotMenuItem.item1){
              showDialog(context: context, builder: (ctx){
                return AlertDialog(
                  title: Text('Delete'),
                  content: Text('Are you sure to delete the history'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                    TextButton(onPressed: (){
                      _clearChat();
                      Navigator.pop(context);
                    }, child: Text('Delete'))
                  ],
                );
              }
              );
             }
           },
            itemBuilder: (context) => [
            PopupMenuItem(
              value: ChatBotMenuItem.item1,
              child: Text('Delete history')),
          ])
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          image: DecorationImage(
            image: AssetImage("assets/robot.jpg"), // Add this asset or remove if not available
            opacity: 0.1,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Empty state
            if (messages.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: appBarColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 40,
                          color: appBarColor,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Welcome to CoursePoint Assistant",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "Ask me anything about your courses, assignments, or learning materials!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Messages list
            if (messages.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show typing indicator at the end
                    if (_isTyping && index == messages.length) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 8, right: 80),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildTypingDot(),
                              SizedBox(width: 5),
                              _buildTypingDot(delay: 300),
                              SizedBox(width: 5),
                              _buildTypingDot(delay: 600),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    // Message items
                    bool isUser = messages[index].role == "user";
                    bool showAvatar = index == 0 || messages[index].role != messages[index - 1].role;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          // Bot avatar
                          if (!isUser && showAvatar)
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                backgroundColor: appBarColor,
                                radius: 16,
                                child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
                              ),
                            ),
                            
                          // Message bubble
                          Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                              ),
                              margin: EdgeInsets.only(
                                top: 4,
                                left: !isUser && !showAvatar ? 40 : 0,
                                right: isUser && !showAvatar ? 40 : 0,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isUser 
                                    ? appBarColor
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                  bottomLeft: isUser ? Radius.circular(18) : Radius.circular(2),
                                  bottomRight: isUser ? Radius.circular(2) : Radius.circular(18),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Text(
                                messages[index].text,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isUser ? Colors.black87 : Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            
            // Input area
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, -1),
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [appBarColor, appBarColor.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: appBarColor.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: _chatController.isSending ? null : _sendMessage,
                          child: Center(
                            child: _chatController.isSending
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Animated typing dot
  Widget _buildTypingDot({int delay = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: ((math.sin((value * 2 * math.pi) + (delay / 1000)) + 1) / 2) * 0.8 + 0.2,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: appBarColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}








































// import 'package:coursepoint/database/model/chat_message.dart';
// import 'package:coursepoint/services/api_service.dart';
// import 'package:coursepoint/widget/apppcolor.dart';
// import 'package:coursepoint/widget/chat_bot_menu_items.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// // Create a singleton pattern for ChatService to ensure only one instance exists
// class ChatServiceSingleton {
//   static final ChatServiceSingleton _instance = ChatServiceSingleton._internal();
//   final ChatService chatService = ChatService();
  
//   factory ChatServiceSingleton() {
//     return _instance;
//   }
  
//   ChatServiceSingleton._internal();
// }

// class ChatScreen extends StatefulWidget {
//   final String userId;

//   ChatScreen({required this.userId});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   // Use the singleton instance
//   final ChatService _chatService = ChatServiceSingleton().chatService;
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<ChatMessage> messages = [];
//   late String userId;
//   bool _isSending = false; // Flag to track if a message is currently being sent

//   @override
//   void initState() {
//     super.initState();
//     userId = widget.userId;
//     loadChatHistory();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void loadChatHistory() {
//     List<ChatMessage> history = _chatService.getChatHistory(userId);
//     setState(() {
//       messages = history;
//     });
//     _scrollToBottom();
//   }

//   void _scrollToBottom() {
//     // Scroll to bottom of list view after rendering
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   Future<void> sendMessage() async {
//     if (_controller.text.isEmpty || _isSending) return;

//     // Set flag to prevent double sending
//     _isSending = true;
    
//     String userMessage = _controller.text.trim();
//     _controller.clear();

//     try {
//       // Add user message to UI
//       setState(() {
//         messages.add(ChatMessage(role: "user", text: userMessage));
//       });
      
//       _scrollToBottom();

//       // Save to database
//       _chatService.saveMessage(userId, "user", userMessage);

//       // Show typing indicator
//       setState(() {
//         _isTyping = true;
//       });

//       // Fetch bot response
//       String botResponse = await _chatService.fetchBotResponse(userId, userMessage);

//       // Check if component is still mounted before updating state
//       if (mounted) {
//         setState(() {
//           _isTyping = false;
//           messages.add(ChatMessage(role: "bot", text: botResponse));
//         });
        
//         _scrollToBottom();
//       }

//       // Save bot response to database
//       _chatService.saveMessage(userId, "bot", botResponse);
//     } catch (e) {
//       print("Error sending message: $e");
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Couldn't send message. Please try again."),
//             backgroundColor: Colors.red.shade400,
//           ),
//         );
//       }
//     } finally {
//       // Reset sending flag
//       _isSending = false;
//     }
//   }

//   void clearChat(){
//     setState(() {
//       messages.clear();
//     });
//     _chatService.clearChatHistory(userId);
//   }

//   bool _isTyping = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         elevation: 0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 16,
//               child: Icon(Icons.smart_toy, color: appBarColor, size: 20),
//             ),
//             SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "AI Assistant",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   _isTyping ? "Typing..." : "Online",
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           PopupMenuButton<ChatBotMenuItem>(
//            onSelected: (value) {
//              if(value == ChatBotMenuItem.item1){
//               showDialog(context: context, builder: (ctx){
//                 return AlertDialog(
//                   title: Text('Delete'),
//                   content: Text('Are you sure to delete the history'),
//                   actions: [
//                     TextButton(onPressed: (){
//                       Navigator.pop(context);
//                     }, child: Text('Cancel')),
//                     TextButton(onPressed: (){
//                       clearChat();
//                       Navigator.pop(context);
//                     }, child: Text('Delete'))
//                   ],
//                 );
//               }
//               );
//              }
//            },
//             itemBuilder: (context) => [
//             PopupMenuItem(
//               value: ChatBotMenuItem.item1,
//               child: Text('Delete history')),
//           ])
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade50,
//           image: DecorationImage(
//             image: AssetImage("assets/robot.jpg"), // Add this asset or remove if not available
//             opacity: 0.1,
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             // Empty state
//             if (messages.isEmpty)
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           color: appBarColor.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.chat_bubble_outline,
//                           size: 40,
//                           color: appBarColor,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         "Welcome to CoursePoint Assistant",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey.shade800,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 32),
//                         child: Text(
//                           "Ask me anything about your courses, assignments, or learning materials!",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
            
//             // Messages list
//             if (messages.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   padding: EdgeInsets.all(16),
//                   itemCount: messages.length + (_isTyping ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     // Show typing indicator at the end
//                     if (_isTyping && index == messages.length) {
//                       return Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           margin: EdgeInsets.only(top: 8, right: 80),
//                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildTypingDot(),
//                               SizedBox(width: 5),
//                               _buildTypingDot(delay: 300),
//                               SizedBox(width: 5),
//                               _buildTypingDot(delay: 600),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
                    
//                     // Message items
//                     bool isUser = messages[index].role == "user";
//                     bool showAvatar = index == 0 || messages[index].role != messages[index - 1].role;
                    
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 8),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//                         children: [
//                           // Bot avatar
//                           if (!isUser && showAvatar)
//                             Padding(
//                               padding: EdgeInsets.only(right: 8),
//                               child: CircleAvatar(
//                                 backgroundColor: appBarColor,
//                                 radius: 16,
//                                 child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
//                               ),
//                             ),
                            
//                           // Message bubble
//                           Flexible(
//                             child: Container(
//                               constraints: BoxConstraints(
//                                 maxWidth: MediaQuery.of(context).size.width * 0.75,
//                               ),
//                               margin: EdgeInsets.only(
//                                 top: 4,
//                                 left: !isUser && !showAvatar ? 40 : 0,
//                                 right: isUser && !showAvatar ? 40 : 0,
//                               ),
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                               decoration: BoxDecoration(
//                                 color: isUser 
//                                     ? appBarColor
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(18),
//                                   topRight: Radius.circular(18),
//                                   bottomLeft: isUser ? Radius.circular(18) : Radius.circular(2),
//                                   bottomRight: isUser ? Radius.circular(2) : Radius.circular(18),
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.05),
//                                     blurRadius: 3,
//                                     offset: Offset(0, 1),
//                                   ),
//                                 ],
//                               ),
//                               child: Text(
//                                 messages[index].text,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: isUser ? Colors.white : Colors.black87,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ),
//                           ),
                          
//                           // User avatar  
//                           // if (isUser && showAvatar)
//                           //   Padding(
//                           //     padding: EdgeInsets.only(left: 8),
//                           //     child: CircleAvatar(
//                           //       backgroundColor: Colors.white,
//                           //       radius: 16,
//                           //       child: Icon(Icons.person, color: appBarColor, size: 18),
//                           //     ),
//                           //   ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
            
//             // Input area
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     offset: Offset(0, -1),
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: SafeArea(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: TextField(
//                           controller: _controller,
//                           maxLines: null,
//                           textCapitalization: TextCapitalization.sentences,
//                           decoration: InputDecoration(
//                             hintText: "Type your message...",
//                             hintStyle: TextStyle(color: Colors.grey.shade500),
//                             border: InputBorder.none,
//                           ),
//                           onSubmitted: (_) => sendMessage(),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Container(
//                       height: 48,
//                       width: 48,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [appBarColor, appBarColor.withOpacity(0.8)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(24),
//                         boxShadow: [
//                           BoxShadow(
//                             color: appBarColor.withOpacity(0.3),
//                             blurRadius: 5,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(24),
//                           onTap: _isSending ? null : sendMessage,
//                           child: Center(
//                             child: _isSending
//                                 ? SizedBox(
//                                     width: 24,
//                                     height: 24,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : Icon(
//                                     Icons.send_rounded,
//                                     color: Colors.white,
//                                     size: 22,
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   // Animated typing dot
//   Widget _buildTypingDot({int delay = 0}) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: 1500),
//       curve: Curves.easeInOut,
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: ((math.sin((value * 2 * math.pi) + (delay / 1000)) + 1) / 2) * 0.8 + 0.2,
//           child: Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: appBarColor.withOpacity(0.7),
//               shape: BoxShape.circle,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // Add this import at the top of your file

