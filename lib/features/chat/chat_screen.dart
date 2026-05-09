import 'package:appchat_flutter/core/overlay/toast_overlay.dart';
import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:appchat_flutter/features/chat_detail/chat_detail_screen.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Trò chuyện"),
        TextField(decoration: InputDecoration(hintText: "Tìm kiếm")),
        Divider(color: Colors.blue),
        Expanded(
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state.status == StatusType.error && state.msg != null) {
                ToastOverlay.showToastBottom(state.msg!, false);
              }
            },
            builder: (context, state) => ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) =>
                  _buildChat(state.chats[index], context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChat(Chat chat, BuildContext context) {
    final AppUser friend = chat.friend;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChatDetailCubit(),
            child: ChatDetailScreen(
              chatId: chat.id,
              friend: AppUser(
                id: friend.id,
                displayName: friend.displayName,
                userName: friend.userName,
                avatarUrl: friend.avatarUrl,
              ),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 55,
              child: Image.asset(
                friend.avatarUrl ?? "./assets/avatars/default.png",
              ),
            ),
            const SizedBox(width: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(chat.lastMessage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
