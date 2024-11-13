import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/util/pallet.dart';
import '../data/model/message.dart';

class ChatListScreen extends StatelessWidget {
  final String currentUserId;

  const ChatListScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text('Client'),
          backgroundColor: Pallet.whiteColor,
          elevation: 5,
        ),
        SliverToBoxAdapter(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .where('receiverId', isEqualTo: currentUserId)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                log('Error: ${snapshot.error}');
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Pallet.primaryColor,
                  ),
                );
              }

              Map<String, Message> latestMessages = {};
              for (var doc in snapshot.data!.docs) {
                Message message =
                    Message.fromJson(doc.data() as Map<String, dynamic>);
                String otherUserId = message.senderId == currentUserId
                    ? message.receiverId
                    : message.senderId;

                if (!latestMessages.containsKey(otherUserId) ||
                    message.timestamp.isAfter(
                      latestMessages[otherUserId]!.timestamp,
                    )) {
                  latestMessages[otherUserId] = message;
                }
              }

              if (latestMessages.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No messages yet'),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestMessages.length,
                itemBuilder: (context, index) {
                  String userId = latestMessages.keys.elementAt(index);
                  Message message = latestMessages[userId]!;

                  return ChatListTile(
                    userId: userId,
                    lastMessage: message,
                    currentUserId: currentUserId,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          otherUserId: userId,
                          currentUserId: currentUserId,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}

class ChatListTile extends StatelessWidget {
  final String userId;
  final Message lastMessage;
  final String currentUserId;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.userId,
    required this.lastMessage,
    required this.currentUserId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;
        final String? profilePhoto = userData['profilePhoto'];
        final String name = userData['name'] ?? 'Unknown User';

        return ListTile(
          leading: profilePhoto != null && profilePhoto.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(profilePhoto),
                  backgroundColor: Pallet.greyColor,
                )
              : _buildInitialAvatar(name),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            lastMessage.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
          trailing: Text(
            _formatDateTime(lastMessage.timestamp),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      },
    );
  }

  Widget _buildInitialAvatar(String name) {
    return CircleAvatar(
      backgroundColor: Pallet.primaryColor,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return _getDayOfWeek(dateTime.weekday);
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}

class ChatScreen extends StatelessWidget {
  final String otherUserId;
  final String currentUserId;
  final TextEditingController _messageController = TextEditingController();

  ChatScreen({
    super.key,
    required this.otherUserId,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(otherUserId)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            }

            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(userData['name'] ?? 'Unknown User');
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('senderId', whereIn: [currentUserId, otherUserId])
                  .where('receiverId', whereIn: [currentUserId, otherUserId])
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Pallet.primaryColor,
                    ),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Message message = Message.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);
                    return MessageBubble(
                      message: message,
                      isMe: message.senderId == currentUserId,
                    );
                  },
                );
              },
            ),
          ),
          ChatInputField(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final message = Message(
      senderId: currentUserId,
      receiverId: otherUserId,
      text: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isAgent: false,
    );
    await FirebaseFirestore.instance
        .collection('messages')
        .add(message.toJson());

    _messageController.clear();
  }
}

// message_bubble.dart
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Pallet.primaryColor : Pallet.greyColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
              Text(
                _formatTime(message.timestamp),
                style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type your message',
                hintStyle: const TextStyle(
                  color: Pallet.greyColor2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Pallet.greyContainerColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: onSend,
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallet.primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            child: const Icon(
              Icons.send,
              color: Pallet.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
