import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:morshd/features/home/ui/home.dart';
import 'package:morshd/core/mycore/helper/shared_pref_helper.dart';
import 'package:morshd/core/mycore/logic/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser botUser = ChatUser(
    id: "1",
    firstName: "Bot",
    profileImage: "assets/images/Pharaonic_chatbot.jpg",
  );

  //for emulator
  final String apiUrl = 'http://192.168.1.5:3000/chat/';
  // final String apiUrl = 'http://10.0.2.2:3000/chat/';
  // final String apiUrl = 'http://localhost:3000/chat/';
  //final String apiUrl = 'http://192.168.1.8:3000/chat/';

  String? _chatMessagesKey;

  @override
  void initState() {
    super.initState();
    // We'll initialize the chat key after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeChatKey();
    });
  }

  Future<void> _initializeChatKey() async {
    // Get current user from UserCubit
    final userCubit = context.read<UserCubit>();
    final currentUser = userCubit.state.user;

    if (currentUser != null && currentUser.id.isNotEmpty) {
      _chatMessagesKey = 'chat_messages_${currentUser.id}';
      // Update the chat user with actual user name
      setState(() {
        this.currentUser = ChatUser(
          id: currentUser.id,
          firstName: currentUser.firstName,
          lastName: currentUser.lastName,
        );
      });
      log('Chat key initialized for user: ${currentUser.userName} (ID: ${currentUser.id})');
      await _loadMessages();
    } else {
      log('No user found, using default chat key');
      _chatMessagesKey = 'chat_messages_guest';
      await _loadMessages();
    }
  }

  Future<void> _loadMessages() async {
    if (_chatMessagesKey == null) return;

    try {
      final savedMessagesJson =
          await SharedPrefHelper.getString(_chatMessagesKey!);
      if (savedMessagesJson.isNotEmpty) {
        final List<dynamic> messagesList = jsonDecode(savedMessagesJson);
        final List<ChatMessage> loadedMessages =
            messagesList.map((messageJson) {
          return ChatMessage.fromJson(messageJson);
        }).toList();

        setState(() {
          messages = loadedMessages;
        });
        log('Loaded ${messages.length} messages for user from local storage');
      }
    } catch (e) {
      log('Error loading messages: $e');
    }
  }

  Future<void> _saveMessages() async {
    if (_chatMessagesKey == null) return;

    try {
      final messagesJson = messages.map((message) => message.toJson()).toList();
      final jsonString = jsonEncode(messagesJson);
      await SharedPrefHelper.setData(_chatMessagesKey!, jsonString);
      log('Saved ${messages.length} messages for user to local storage');
    } catch (e) {
      log('Error saving messages: $e');
    }
  }

  Future<void> _clearMessages() async {
    if (_chatMessagesKey == null) return;

    try {
      await SharedPrefHelper.removeData(_chatMessagesKey!);
      setState(() {
        messages = [];
      });
      log('Cleared all messages for user from local storage');
    } catch (e) {
      log('Error clearing messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        // When user changes, reinitialize chat key and load messages
        if (state.user != null && _chatMessagesKey != null) {
          final newChatKey = 'chat_messages_${state.user!.id}';
          if (_chatMessagesKey != newChatKey) {
            _chatMessagesKey = newChatKey;
            // Update the chat user with actual user name
            setState(() {
              currentUser = ChatUser(
                id: state.user!.id,
                firstName: state.user!.firstName,
                lastName: state.user!.lastName,
              );
            });
            _loadMessages();
            log('Chat key updated for user: ${state.user!.userName} (ID: ${state.user!.id})');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("assistant Tour Guide "),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Home(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                _showClearMessagesDialog();
              },
              tooltip: 'Clear Chat',
            ),
          ],
        ),
        body: _buildUI(),
      ),
    );
  }

  void _showClearMessagesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Chat'),
          content: const Text('Are you sure you want to clear the chat?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearMessages();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        // IconButton(
        //   onPressed: _sendMediaMessage,
        //   icon: const Icon(Icons.image),
        // )
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    // Add user message immediately
    setState(() {
      messages = [chatMessage, ...messages];
    });
    await _saveMessages();

    // Create the bot's message object once
    // We'll update its 'text' field directly later
    final ChatMessage botResponseMsg = ChatMessage(
      user: botUser,
      createdAt: DateTime.now(),
      text: '', // Start with an empty text
    );

    setState(() {
      messages = [botResponseMsg, ...messages];
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': chatMessage.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log("🔁 API RESPONSE: $data");

        final botReply = data['text'];

        if (botReply == null || botReply.isEmpty) {
          _showError("⚠️ Unexpected API response: $data");
          // Remove the bot's empty message if there's no valid reply
          setState(() {
            messages.remove(botResponseMsg);
          });
          return;
        }

        final words = botReply.split(' ');
        String currentDisplayedText = '';

        // Iterate through words and update the existing botResponseMsg
        for (int i = 0; i < words.length; i++) {
          await Future.delayed(const Duration(milliseconds: 50)); // Adjust delay
          currentDisplayedText += (i > 0 ? ' ' : '') + words[i];

          // Update the text property of the existing ChatMessage object
          // and then trigger a rebuild
          setState(() {
            botResponseMsg.text = currentDisplayedText;
          });
        }
        await _saveMessages(); // Save messages after the full reply is displayed

      } else {
        _showError("Error: ${response.statusCode}");
        // Remove the bot's empty message if there's an error
        setState(() {
          messages.remove(botResponseMsg);
        });
      }
    } catch (e) {
      log('❌ ERROR: $e');
      _showError("Failed to connect to API");
      // Remove the bot's empty message if there's an error
      setState(() {
        messages.remove(botResponseMsg);
      });
    }
  }

  void _showError(String message) {
    ChatMessage errorMsg = ChatMessage(
      user: botUser,
      createdAt: DateTime.now(),
      text: message,
    );

    setState(() {
      messages = [errorMsg, ...messages];
    });

    _saveMessages();
  }
}