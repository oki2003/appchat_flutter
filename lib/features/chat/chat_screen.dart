import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/chat/cubit/chat.vm.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/widgets/user_presence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state.status == StatusType.loaded) {
          if (state.chats.isEmpty) {
            return const Text("Không có bạn bè rồi");
          } else {
            final List<Chat> chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/chat_detail",
                    arguments: chats[index],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFE4E4E7)),
                    ),
                  ),
                  child: Row(
                    children: [
                      UserPresence(
                        avatarURL: chats[index].friend.avatarURL.toString(),
                        size: 40,
                        status: chats[index].status,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chats[index].friend.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      chats[index].unreadMessages > 0
                          ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF7851DE),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                chats[index].unreadMessages.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.chats.isEmpty) {
          return const Text("Không có bạn bè rồi");
        }
        return ListView.builder(
          itemCount: viewModel.chats.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                "/chat_detail",
                arguments: viewModel.chats[index],
              );
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE4E4E7))),
              ),
              child: Row(
                children: [
                  UserPresence(
                    avatarURL: viewModel.chats[index].friend.avatarURL
                        .toString(),
                    size: 40,
                    status: viewModel.chats[index].status,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.chats[index].friend.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  viewModel.chats[index].unreadMessages > 0
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF7851DE),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            viewModel.chats[index].unreadMessages.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
