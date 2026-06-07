import 'package:appchat_flutter/enums/status_type.dart';
import 'package:appchat_flutter/features/chat/cubit/chat_cubit.dart';
import 'package:appchat_flutter/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:appchat_flutter/features/chat_detail/chat_detail_screen.dart';
import 'package:appchat_flutter/models/app_user.dart';
import 'package:appchat_flutter/models/chat.dart';
import 'package:appchat_flutter/theme/brand_theme.dart';
import 'package:appchat_flutter/widgets/error_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(15.0),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Tìm kiếm")),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                switch (state.status) {
                  case StatusType.loading:
                    return _buildSkeleton();
                  case StatusType.error:
                    return ErrorWidgetCustom(
                      message: state.msg ?? "",
                      onRefresh: () => context.read<ChatCubit>().fetchChats(),
                    );
                  case StatusType.loaded:
                    return ListView.builder(
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) =>
                          _buildChatItem(state.chats[index], context),
                    );
                  default:
                    return ErrorWidgetCustom(
                      message: state.msg ?? "",
                      onRefresh: () => context.read<ChatCubit>().fetchChats(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Chat chat, BuildContext context) {
    final AppUser friend = chat.friend;
    final bool hasCustomAvatar =
        friend.avatarUrl != null &&
        friend.avatarUrl!.isNotEmpty &&
        !friend.avatarUrl!.contains('default.png');
    final BrandAppTheme brandAppTheme = BrandAppTheme(context: context);

    return GestureDetector(
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: brandAppTheme.containerColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: hasCustomAvatar
                        ? null
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF812E6B), // Deep purple
                              Color(0xFFC73659), // Magenta/red-purple
                              Color(0xFFE65C40), // Red-orange
                            ],
                          ),
                  ),
                  child: hasCustomAvatar
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Image.asset(
                            friend.avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        friend.displayName,
                        style: TextStyle(
                          color: brandAppTheme.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chat.lastMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: brandAppTheme.noteBrandColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
