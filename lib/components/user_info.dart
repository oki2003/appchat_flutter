import 'package:appchat_flutter/providers/user_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({
    super.key,
    required this.id,
    required this.avatarURL,
    required this.name,
    required this.time,
  });

  final String id;
  final String avatarURL;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStatusList = ref.watch(userStatusProvider);

    return Row(
      children: [
        Stack(
          children: [
            // Hiển thị ảnh avatar
            Image.asset(avatarURL, width: 40),

            // Xử lý trạng thái dữ liệu khi đã có dữ liệu hoặc trong trạng thái lỗi/loading
            userStatusList.when(
              // Khi dữ liệu có sẵn
              data: (userList) {
                // Sử dụng orElse để trả về một đối tượng mặc định nếu không tìm thấy
                final user = userList.firstWhere(
                  (element) => element['idUser'] == id,
                  orElse: () => {
                    'idUser': id,
                    'isOnline': false,
                  }, // Giá trị mặc định khi không tìm thấy
                );

                // Kiểm tra trạng thái online
                if (user['isOnline'] == true) {
                  return Positioned(
                    bottom: -2,
                    right: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  );
                }
                // Nếu không online, không làm gì
                return SizedBox.shrink(); // Không chiếm không gian và không làm gì
              },

              // Khi có lỗi
              error: (error, stackTrace) {
                return Center(child: Text('Error: $error'));
              },

              // Khi dữ liệu đang được tải
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ],
        ),

        // Khoảng cách giữa avatar và tên
        SizedBox(width: 20),

        // Hiển thị tên và thời gian
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ],
    );
  }
}
