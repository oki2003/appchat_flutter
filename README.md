# 💬 Flutter Realtime Chat App

Ứng dụng **chat & mạng xã hội mini** được xây dựng bằng **Flutter** và **Firebase**, cho phép người
dùng **đăng bài, nhắn tin realtime,** và **quản lý hồ sơ cá nhân**.  
Dự án hướng tới trải nghiệm mượt mà, giao diện hiện đại và đồng bộ dữ liệu thời gian thực.

---

## 🚀 Tính năng chính

- 📝 **Đăng bài viết:** Người dùng có thể đăng bài kèm hình ảnh và văn bản.
- 💬 **Chat realtime 1-1:** Tin nhắn được đồng bộ tức thì qua **Cloud Firestore**.
- 🧠 **Lazy loading:** Tối ưu tốc độ hiển thị bài viết và tin nhắn khi tải dữ liệu lớn.
- ⚡ **Cache cục bộ:** Giảm tải truy vấn Firestore, tăng tốc độ tải UI.
- 🔐 **Xác thực người dùng:** Firebase Authentication (Email/Password hoặc Google Sign-in).
- 🧩 **Kiến trúc MVVM:** Dễ mở rộng, dễ bảo trì và tách biệt rõ ràng giữa UI - logic - dữ liệu.

---

## 🧰 Công nghệ sử dụng

| Thành phần             | Công nghệ                          |
|------------------------|------------------------------------|
| **Frontend**           | Flutter                            |
| **State Management**   | Provider / Riverpod                |
| **Backend & Database** | Firebase Firestore                 |
| **Authentication**     | Firebase Auth                      |
| **Storage**            | Firebase Storage                   |
| **Architecture**       | MVVM                               |
| **Other**              | Cache, Lazy Loading, StreamBuilder |

---

## 📂 Cấu trúc thư mục

```bash
lib/
├── models/          # Định nghĩa các model dữ liệu (Post, Message,...)
├── viewmodels/      # Xử lý logic & kết nối dữ liệu theo mô hình MVVM
├── views/           # Giao diện màn hình (Home, Chat, Profile,...)
├── widgets/         # Các widget tái sử dụng
└── main.dart        # Điểm khởi chạy ứng dụng
