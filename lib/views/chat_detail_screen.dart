import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/utils/utils.dart';
import 'package:appchat_flutter/view_models/chat_detail_view_model.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatDetailScreen();
  }
}

class _ChatDetailScreen extends State<ChatDetailScreen> {
  late final ChatDetailViewModel chatDetailViewModel;

  @override
  void initState() {
    super.initState();
    chatDetailViewModel = ChatDetailViewModel();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatDetailViewModel.chat =
          ModalRoute.of(context)!.settings.arguments as Chat;
      chatDetailViewModel.getMessages();
    });
  }

  @override
  void dispose() {
    chatDetailViewModel.updateCurrent();
    chatDetailViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: chatDetailViewModel,
      builder: (context, child) {
        if (chatDetailViewModel.messages == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset(
                  chatDetailViewModel.chat.avatarURLFriend,
                  width: 40,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatDetailViewModel.chat.nameFriend,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Đang hoạt động",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: chatDetailViewModel.messages == null
                    ? Center(child: CircularProgressIndicator())
                    : StreamBuilder(
                        stream: chatDetailViewModel.messages,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              chatDetailViewModel.scrollController.jumpTo(
                                chatDetailViewModel
                                    .scrollController
                                    .position
                                    .maxScrollExtent,
                              );
                            });
                            return ListView(
                              controller: chatDetailViewModel.scrollController,
                              padding: EdgeInsets.only(left: 30, right: 30),
                              children: [
                                SizedBox(height: 10),
                                ...snapshot.data!.map((message) {
                                  return Align(
                                    alignment:
                                        message.senderId ==
                                            chatDetailViewModel.currentUserId
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: message.text == '👍'
                                        ? Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Icon(
                                              Icons.thumb_up,
                                              color: Color(0xFF7851DE),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  message.senderId ==
                                                      chatDetailViewModel
                                                          .currentUserId
                                                  ? Color(0xFF7851DE)
                                                  : Color(0xFFF4F4F5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                            chatDetailViewModel
                                                                .currentUserId
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
                        controller: chatDetailViewModel.textEditingController,
                        onChanged: (value) {
                          if (value.isNotEmpty != chatDetailViewModel.hasText) {
                            setState(() {
                              chatDetailViewModel.hasText =
                                  !chatDetailViewModel.hasText;
                            });
                          }
                        },
                        decoration: InputDecoration(hintText: 'Nhắn tin'),
                      ),
                    ),
                    SizedBox(width: 10),
                    chatDetailViewModel.hasText
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(4),
                            ),
                            onPressed: () {
                              chatDetailViewModel.sendMessage(
                                chatDetailViewModel.textEditingController.text,
                                chatDetailViewModel.chat.idChat,
                              );
                              chatDetailViewModel.textEditingController.clear();
                            },
                            child: Icon(Icons.send_sharp),
                          )
                        : IconButton(
                            onPressed: () {
                              chatDetailViewModel.sendMessage(
                                '👍',
                                chatDetailViewModel.chat.idChat,
                              );
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: Color(0xFF7851DE),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
