import 'package:appchat_flutter/components/user_info.dart';
import 'package:appchat_flutter/controller/chat_controller.dart';
import 'package:appchat_flutter/controller/message_controller.dart';
import 'package:appchat_flutter/models/friend.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:appchat_flutter/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter/material.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatDetail();
  }
}

class _ChatDetail extends State<ChatDetail> {
  Stream<List<Message>>? messages;
  final MessageController messageController = MessageController();
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController textEditingController = TextEditingController();
  bool hasText = false;
  String idChat = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final agrs = ModalRoute.of(context)!.settings.arguments as List;
      idChat = agrs[1];
      messages = messageController.getMessages(idChat);
      setState(() {});
    });
  }

  @override
  void dispose() {
    final ChatController chatController = ChatController();
    chatController.updateCurrent(idChat);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context)!.settings.arguments as List;
    final Friend profile = agrs[0];

    return Scaffold(
      appBar: AppBar(
        // title: Row(
        //   children: [
        //     Image.network(
        //       profile.avatarURL,
        //       width: 40,
        //       errorBuilder: (context, error, stackTrace) {
        //         return Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(50),
        //             color: Colors.grey,
        //           ),
        //           width: 40,
        //           height: 40,
        //           child: Icon(Icons.person, size: 24),
        //         );
        //       },
        //     ),
        //     SizedBox(width: 20),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           profile.name,
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //         ),
        //         Text(
        //           "Đang hoạt động",
        //           style: TextStyle(fontSize: 11, color: Colors.grey),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        //
        title: UserInfo(
          id: profile.id,
          avatarURL: profile.avatarURL,
          name: profile.name,
          time: "",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages == null
                ? Center(child: CircularProgressIndicator())
                : StreamBuilder(
                    stream: messages,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          children: [
                            SizedBox(height: 10),
                            ...snapshot.data!.map((message) {
                              return Align(
                                alignment: message.senderId == currentUserId
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: message.text == '👍'
                                    ? Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFF7851DE),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:
                                              message.senderId == currentUserId
                                              ? Color(0xFF7851DE)
                                              : Color(0xFFF4F4F5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              message.text,
                                              style: TextStyle(
                                                color:
                                                    message.senderId ==
                                                        currentUserId
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              Utils().formatTime(
                                                message.createdAt,
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              );
                            }),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            padding: EdgeInsets.all(17),
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      if (value.isNotEmpty != hasText) {
                        setState(() {
                          hasText = !hasText;
                        });
                      }
                    },
                    decoration: InputDecoration(hintText: 'Nhắn tin'),
                  ),
                ),
                SizedBox(width: 10),
                hasText
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: () {
                          messageController.sendMessage(
                            textEditingController.text,
                            idChat,
                          );
                        },
                        child: Icon(Icons.send_sharp),
                      )
                    : IconButton(
                        onPressed: () {
                          messageController.sendMessage('👍', idChat);
                        },
                        icon: Icon(Icons.thumb_up, color: Color(0xFF7851DE)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
