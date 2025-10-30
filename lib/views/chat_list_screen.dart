import 'package:appchat_flutter/view_models/chat_list_view_model.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatListScreen();
  }
}

class _ChatListScreen extends State<ChatListScreen> {
  late final ChatListViewModel chatListViewModel;

  @override
  void initState() {
    super.initState();
    chatListViewModel = ChatListViewModel();
    chatListViewModel.initStreamListChat();
  }

  @override
  void dispose() {
    chatListViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: chatListViewModel,
      builder: (context, child) {
        if (chatListViewModel.chats == null) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: chatListViewModel.chats,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  SizedBox(height: 20),
                  ...snapshot.data!.map(
                    (chat) => InkWell(
                      onTap: () {
                        chatListViewModel.updateCurrentAndCount(chat);
                        Navigator.pushNamed(
                          context,
                          '/chat_detail',
                          arguments: chat,
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
                            Image.asset(chat.avatarURLFriend, width: 40),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chat.nameFriend,
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
                                              chatListViewModel.currentUserId !=
                                                  chat.idLastUser)
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (chatListViewModel.currentUserId != chat.idLastUser)
                                ? Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: (chat.count > 0)
                                          ? Color(0xFF7851DE)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      chat.count > 0
                                          ? chat.count.toString()
                                          : "",
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
      },
    );
  }
}
