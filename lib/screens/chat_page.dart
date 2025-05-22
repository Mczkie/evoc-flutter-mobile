import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:evocapp/screens/chat_provider.dart';

class ChatPage extends StatefulWidget {
  final String userId;

  const ChatPage({super.key, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  final _user = types.User(id: const Uuid().v4()); // Random local user ID

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io(
      'http://192.168.1.249:5000', // Use your computer's local IP address
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // Disable auto-connect, you want to control when the socket connects
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("Connected to socket");
      socket.emit('join', widget.userId); // Emit the user ID when connected
    });

    socket.onError((error) {
      print("Socket Error: $error");
      // Handle error, show message to user or retry connection
    });

    socket.onDisconnect((_) {
      print("Socket Disconnected");
      // Handle disconnection, e.g., attempt to reconnect
    });

    socket.on('message', (data) {
      print('Received: $data');
      if (data != null && data.containsKey('message')) {
        final textMessage = types.TextMessage(
          author: types.User(id: 'admin'),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: data['message'],
        );
        // Update the messages in the provider
        Provider.of<ChatProvider>(context, listen: false)
            .addMessage(textMessage);
      }
    });

    socket.on('sendMessage', (data) {
      print('Message sent: $data');
    });
  }

  void handleSend(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    // Add the new message to the provider
    Provider.of<ChatProvider>(context, listen: false).addMessage(textMessage);

    socket.emit('message', {
      'userId': widget.userId,
      'message': message.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Admin")),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Chat(
            messages: chatProvider.messages,
            onSendPressed: handleSend,
            user: _user,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect(); // Disconnect the socket on dispose
    socket.dispose(); // Dispose the socket connection
    super.dispose();
  }
}
