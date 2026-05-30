import 'package:appchat_flutter/core/overlay/toast_overlay.dart';
import 'package:appchat_flutter/enums/message_status.dart';
import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class ChatDetailScreen extends StatefulWidget {
  final AppUser friend;
  final int? chatId;

  const ChatDetailScreen({
    super.key,
    required this.friend,
    required this.chatId,
  });

  @override
  State<StatefulWidget> createState() => _ChatDetailScreen();
}

class _ChatDetailScreen extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final inputDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(style: BorderStyle.none),
  );
  bool _isTyping = false;
  final ValueNotifier<bool> _isShowOption = ValueNotifier<bool>(false);
  late final AppUser friend;

  @override
  void initState() {
    friend = widget.friend;
    context.read<ChatDetailCubit>().chatId = widget.chatId;
    context.read<ChatDetailCubit>().fetchMessages(widget.chatId);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: _buildAppBar(friend),
          ),
          body: BlocListener<ChatDetailCubit, ChatDetailState>(
            listener: (context, state) {
              if (state.status == StatusType.error && state.msg != null) {
                ToastOverlay.showToastBottom(state.msg!, false);
              }
            },
            child: Column(
              children: [
                Divider(color: Color(0xffe5e7eb), height: 1, thickness: 1),
                BlocBuilder<ChatDetailCubit, ChatDetailState>(
                  builder: (context, state) =>
                      state.status == StatusType.loadmore
                      ? Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      BlocConsumer<ChatDetailCubit, ChatDetailState>(
                        listenWhen: (prev, cur) {
                          if (prev.messages.isNotEmpty &&
                              cur.messages.isNotEmpty) {
                            if (prev.messages.first != cur.messages.first &&
                                cur.messages.first.senderId != friend.id) {
                              return true;
                            }
                            return false;
                          }
                          return false;
                        },
                        listener: (context, state) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_scrollController.hasClients) {
                              _scrollController.animateTo(
                                0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        },
                        buildWhen: (previous, current) =>
                            previous.messages != current.messages,
                        builder: (context, state) {
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scroll) {
                              if (scroll.metrics.pixels ==
                                  scroll.metrics.maxScrollExtent) {
                                context
                                    .read<ChatDetailCubit>()
                                    .loadMoreMessages();
                              }
                              return false;
                            },
                            child: ListView.builder(
                              reverse: true,
                              controller: _scrollController,
                              itemCount: state.messages.length,
                              itemBuilder: (context, index) =>
                                  state.messages[index].senderId == friend.id
                                  ? _buildFriendMessage(state.messages[index])
                                  : _buildMyMessage(state.messages[index]),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: TapRegion(
                          onTapOutside: (_) => _isShowOption.value = false,
                          child: _buildOption(context),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ChatDetailCubit, ChatDetailState>(
                  buildWhen: (previous, current) =>
                      previous.isTyping != current.isTyping,
                  builder: (context, state) => state.isTyping
                      ? _buildTyping(friend)
                      : const SizedBox.shrink(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 0,
                  ),
                  child: Row(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _isShowOption,
                        child: IconButton(
                          onPressed: () {
                            _isShowOption.value = !_isShowOption.value;
                          },
                          icon: const Icon(
                            Icons.grid_view_rounded,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                        builder: (context, value, child) =>
                            TweenAnimationBuilder(
                              tween: Tween(
                                begin: 0.0,
                                end: value ? pi / 4 : 0.0,
                              ),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                              builder: (context, valueAnimation, _) =>
                                  Transform.rotate(
                                    angle: valueAnimation,
                                    child: child,
                                  ),
                            ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            if (!_isTyping) {
                              _isTyping = true;
                              context.read<ChatDetailCubit>().startTyping(
                                friend,
                              );
                              Future.delayed(Duration(seconds: 3), () {
                                if (context.mounted) {
                                  context.read<ChatDetailCubit>().stopTyping(
                                    friend,
                                  );
                                  _isTyping = false;
                                }
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Nhập tin nhắn",
                            hintStyle: TextStyle(fontSize: 17),
                            enabledBorder: inputDecoration,
                            focusedBorder: inputDecoration,
                            fillColor: Color(0xFFe9eaec),
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _textEditingController,
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            if (value.text.isEmpty) return;

                            context.read<ChatDetailCubit>().sendMessage(
                              _textEditingController.text,
                              friend,
                              context.read<AuthCubit>().state.appUser,
                            );

                            _textEditingController.clear();
                          },
                          icon: Icon(
                            value.text.isEmpty ? Icons.thumb_up : Icons.send,
                            color: const Color(0xFF7C3AED),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTyping(AppUser friend) {
    return Text("${friend.displayName} đoạn soạn tin");
  }

  Widget _buildAppBar(AppUser friend) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 0),
      child: Row(
        children: [
          SizedBox(
            height: 45,
            child: Image.asset(
              friend.avatarUrl ?? "./assets/avatars/default.png",
            ),
          ),
          const SizedBox(width: 10),
          Text(
            friend.displayName,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendMessage(Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFe9eaec),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          message.content,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildMyMessage(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF7C3AED),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          message.content,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: _isShowOption,
      child: SizedBox(
        width: screenWidth / 1.7,
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.black.withValues(alpha: 0.1),
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildOptionItem(
                "Chia sẻ phim từ bộ sưu tập",
                Icons.video_collection_rounded,
                () {
                  _isShowOption.value = false;
                },
              ),
            ],
          ),
        ),
      ),
      builder: (context, value, child) => TweenAnimationBuilder(
        duration: Duration(milliseconds: 400),
        tween: value
            ? Tween(begin: 0.0, end: 1.0)
            : Tween(begin: 1.0, end: 0.0),
        curve: Curves.easeOutBack,
        builder: (context, value, _) => Transform.scale(
          scaleX: value,
          scaleY: value,
          alignment: Alignment.bottomLeft,
          child: child,
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    String text,
    IconData icon,
    onTap, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isFirst ? 10 : 0),
        topRight: Radius.circular(isFirst ? 10 : 0),
        bottomLeft: Radius.circular(isLast ? 10 : 0),
        bottomRight: Radius.circular(isLast ? 10 : 0),
      ),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(icon)],
        ),
      ),
    );
  }
}
