# 📱 Mini Social Network App (Flutter)

Ứng dụng **mạng xã hội & chat realtime** được xây dựng bằng **Flutter**, sử dụng **REST API + Socket
**
cho backend chính, và **Firebase chỉ dùng cho Push Notification**.

Dự án áp dụng **Feature-Based Architecture kết hợp BLoC (Cubit)**, hướng tới khả năng mở rộng,
dễ bảo trì và phù hợp với kiến trúc app thực tế trong môi trường doanh nghiệp.

---

## 🚀 Tính năng chính

- 📝 **Bài đăng (Posts)**
    - Load dữ liệu từ REST API
    - Hỗ trợ phân trang (lazy loading)
    - Cache dữ liệu để tối ưu hiệu năng

- 💬 **Chat realtime**
    - Chat 1-1 thông qua **Socket**
    - Cập nhật tin nhắn theo thời gian thực
    - Tách riêng `chat` và `chat_detail` theo feature

- 🔐 **Xác thực người dùng**
    - Đăng nhập / đăng ký qua REST API
    - Lưu token & thông tin user bằng `SharedPreferences`

- 🔔 **Push Notification**
    - Sử dụng **Firebase Cloud Messaging**
    - Firebase **không dùng cho database**

- 👤 **Hồ sơ cá nhân (Profile)**
    - Xem và cập nhật thông tin người dùng
    - Quản lý dữ liệu độc lập theo từng feature

---

## 🧠 Kiến trúc tổng thể

- **Feature-Based Architecture**
- **State Management:** BLoC / Cubit
- **Data Flow một chiều**
- Tách biệt rõ ràng giữa UI – Business Logic – Data

```text
UI (Screen)
  ↓
Cubit / Bloc
  ↓
API / Socket Service
```

---

## 🧰 Công nghệ sử dụng

| Thành phần             | Công nghệ                |
|------------------------|--------------------------|
| Frontend               | Flutter                  |
| State Management       | flutter_bloc (Cubit)     |
| Networking             | Dio                      |
| Realtime Communication | Socket                   |
| Push Notification      | Firebase Cloud Messaging |
| Local Storage          | SharedPreferences        |
| Code Generation        | Freezed                  |
| Architecture           | Feature-Based + BLoC     |

---

## 📂 Cấu trúc thư mục

```bash
lib/
├── constants/
├── core/
├── enums/
├── features/
├── models/
├── services/
├── utils/
├── widgets/
├── firebase_options.dart
└── main.dart
```
