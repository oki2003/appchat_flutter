# 💬 Mini Social Network

Ứng dụng **chat & mạng xã hội mini** được xây dựng bằng **Flutter** và **Firebase**, cho phép người
dùng **đăng bài, nhắn tin realtime,** và **quản lý hồ sơ cá nhân**.  
Dự án hướng tới trải nghiệm mượt mà, giao diện hiện đại và đồng bộ dữ liệu thời gian thực.

---

## 🚀 Tính năng chính

- 📝 **Hiển thị bài đăng và tin nhắn:** Tối ưu với lazy loading và cache , giúp tăng tốc độ hiển thị
  và giảm tải dữ liệu mạng.
- 💬 **Chat realtime 1-1:** Tin nhắn được đồng bộ tức thì qua **Cloud Firestore**.
- 🔐 **Xác thực người dùng:** An toàn với **Firebase Authentication**.
- 🧩 **Kiến trúc MVVM:** Dễ mở rộng, dễ bảo trì và tách biệt rõ ràng giữa UI, logic và dữ liệu.

---

## 🧰 Công nghệ sử dụng

| Thành phần             | Công nghệ                          |
|------------------------|------------------------------------|
| **Frontend**           | Flutter                            |
| **State Management**   | Riverpod                           |
| **Backend & Database** | Firebase Firestore                 |
| **Authentication**     | Firebase Auth                      |
| **Storage**            | Firebase Storage                   |
| **Architecture**       | MVVM                               |
| **Other**              | Cache, Lazy Loading, StreamBuilder |

---

## 📂 Cấu trúc thư mục

```bash
lib/
├── services/        # Các class chịu trách nhiệm tương tác với Firebase
├── repositories/    # Xử lý logic sau khi gọi Firebase 
├── models/          # Định nghĩa các model dữ liệu (Post, Message,...)
├── viewmodels/      # Xử lý logic & kết nối dữ liệu theo mô hình MVVM
├── views/           # Giao diện màn hình (Home, Chat, Profile,...)
├── widgets/         # Các widget tái sử dụng
└── main.dart        # Điểm khởi chạy ứng dụng
