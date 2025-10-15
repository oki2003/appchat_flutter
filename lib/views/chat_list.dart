import 'dart:async';

import 'package:appchat_flutter/controller/chat_controller.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatList();
  }
}

class _ChatList extends State<ChatList> {
  Future<Map<String, dynamic>>? infoChat;
  final ChatController chatController = ChatController();
  Stream<List<Chat>>? chats;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    infoChat = chatController.initInformation();
    final info = await infoChat;
    if (info!.isNotEmpty) {
      chats = chatController.listenChatList(info['friendIds'], info['chatIds']);
      setState(() {});
    }
  }

  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    if (chats == null) return Center(child: CircularProgressIndicator());
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              SizedBox(height: 20),
              ...snapshot.data!.map(
                (chat) => InkWell(
                  onTap: () {
                    chatController.updateCurrentAndCount(
                      chat.idChat,
                      chat.idLastUser != currentUserId ? 0 : chat.count,
                    );
                    Navigator.pushNamed(
                      context,
                      '/chat_detail',
                      arguments: [chat.friend, chat.idChat],
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFE4E4E7)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          chat.friend.avatarURL,
                          width: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey,
                              ),
                              width: 40,
                              height: 40,
                              child: Icon(Icons.person, size: 24),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.friend.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  height: 2,
                                ),
                              ),
                              Text(
                                chat.lastMessage,
                                style: TextStyle(
                                  color:
                                      (chat.count > 0 &&
                                          currentUserId != chat.idLastUser)
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (currentUserId != chat.idLastUser)
                            ? Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: (chat.count > 0)
                                      ? Color(0xFF7851DE)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  chat.count > 0 ? chat.count.toString() : "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
