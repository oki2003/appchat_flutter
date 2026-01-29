import 'package:appchat_flutter/constants/api.dart';
import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatDetailScreen();
  }
}

class _ChatDetailScreen extends State<ChatDetailScreen> {
  final messageController = TextEditingController();
  final ValueNotifier<bool> hasText = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Chat chat = ModalRoute.of(context)!.settings.arguments as Chat;
      context.read<ChatDetailCubit>().fetchMessages(chat.idChat);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Chat chat = ModalRoute.of(context)!.settings.arguments as Chat;
    final AppUser friend = chat.friend;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            UserPresence(
              avatarURL: friend.avatarURL.toString(),
              size: 40,
              status: chat.status,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                chat.status
                    ? const Text(
                        "Đang hoạt động",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatDetailCubit, ChatDetailState>(
              builder: (context, state) {
                if (state.status == StatusType.loading ||
                    state.status == StatusType.init) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (state.messages.isEmpty) {
                    return const Text("Chưa có hội thoại nào cả");
                  } else {
                    final List<Message> messages = state.messages;
                    return Padding(
                      padding: const EdgeInsetsGeometry.only(
                        left: 10,
                        right: 10,
                      ),
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) => Align(
                          alignment: messages[index].idUserReceive == friend.id
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: _buildMessage(
                            messages[index].type,
                            messages[index].content,
                            messages[index].idUserSend != friend.id,
                          ),
                        ),
                      ),
                    );
                  }
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
                    controller: messageController,
                    onChanged: (value) {
                      hasText.value = value.isNotEmpty;
                    },
                    decoration: InputDecoration(hintText: 'Nhắn tin'),
                  ),
                ),
                const SizedBox(width: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: hasText,
                  builder: (context, value, child) {
                    if (value == true) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: () {
                          hasText.value = false;
                          messageController.clear();
                        },
                        child: const Icon(Icons.send_sharp),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Color(0xFF7851DE),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMessage(int type, String content, bool isMyMessage) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: isMyMessage ? Color(0xFF7851DE) : Color(0xFFF4F4F5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (type == 1)
          Text(
            content,
            style: TextStyle(color: isMyMessage ? Colors.white : Colors.black),
          ),
        if (type == 2) Icon(Icons.file_copy_rounded),
        if (type == 3) Icon(Icons.description),
        if (type == 4) Icon(Icons.slideshow),
        if (type == 5) Icon(Icons.file_copy_rounded),
        if (type == 6) Icon(Icons.picture_as_pdf),
        if (type == 7)
          Image.network("${Api.baseURL}/storage/${content.split("-")[1]}"),
      ],
    ),
  );
}
