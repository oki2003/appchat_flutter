# 💬 Flutter Realtime Chat App

Ứng dụng **chat & mạng xã hội mini** được xây dựng bằng **Flutter** và **Firebase**, cho phép người
dùng **đăng bài, nhắn tin realtime,** và **quản lý hồ sơ cá nhân**.  
Dự án hướng tới trải nghiệm mượt mà, giao diện hiện đại và đồng bộ dữ liệu thời gian thực.

---

## 🚀 Tính năng chính

- 🔐 **Đăng nhập / Đăng ký** bằng Email & Google (Firebase Authentication)
- 💬 **Chat Realtime** giữa hai người dùng (Cloud Firestore)
- 📝 **Hiển thị bài viết (Feed)
- 📸 **Tải ảnh đại diện / hình trong bài đăng** (Firebase Storage)
- 🟢 **Hiển thị trạng thái hoạt động** (Online/Offline) của bạn bè
- 🔔 **Thông báo realtime** khi có tin nhắn hoặc tương tác mới
- ☁️ **Quản lý dữ liệu động** bằng Cloud Firestore

---

## 🛠️ Công nghệ sử dụng

| Công nghệ                   | Mục đích                                                     |
|-----------------------------|--------------------------------------------------------------|
| **Flutter**                 | Xây dựng giao diện đa nền tảng (Android, iOS)                |
| **Firebase Authentication** | Đăng nhập bằng Email/Google                                  |
| **Cloud Firestore**         | Lưu trữ bài viết, tin nhắn, người dùng, trạng thái hoạt động |
| **Firebase Storage**        | Lưu trữ hình ảnh và file chia sẻ trong chat                  |

---

## 🗂️ Cấu trúc thư mục

```bash
lib/
├── components/          # Các widget tái sử dụng (buttons, dialogs, cards,...)
├── models/              # Định nghĩa các model dữ liệu (User, Message, Post)
├── controllers/         # Xử lý logic, tương tác Firebase (Auth, Chat, Post,...)
├── views/               # Giao diện các màn hình (Login, Chat, Feed, Profile,...)
├── utils/               # Hàm tiện ích, định dạng thời gian, constant,...
├── firebase_options.dart
└── main.dart
