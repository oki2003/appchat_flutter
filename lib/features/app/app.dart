import 'package:appchat_flutter/features/app/view_model/app.vm.dart';
import 'package:appchat_flutter/services/firebase_service.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppViewModel _appViewModel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _appViewModel = AppViewModel();
    initNotifications();
    super.initState();
  }

  Future<void> initNotifications() async {
    // Init local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    // Save FCM token
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    debugPrint('FCM Token: $token');
    if (token != null) {
      LocalStorage.pref!.setString("fcmToken", token);
      FirebaseService firebaseService = FirebaseService();
      firebaseService.upsertFCMToken(token);
    }

    // Update when FCM token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      FirebaseService firebaseService = FirebaseService();
      firebaseService.upsertFCMToken(newToken);
    });

    // Listen FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'default_channel',
            'Default Channel',
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
      );

      flutterLocalNotificationsPlugin.show(
        id: 0,
        title: message.notification?.title ?? 'Tin nhắn mới',
        body: message.notification?.body ?? 'Bạn có 1 tin nhắn mới',
        notificationDetails: notificationDetails,
      );
    });
  }

  @override
  void dispose() {
    _appViewModel.currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _appViewModel.currentIndex,
      builder: (context, child) => Scaffold(
        body: IndexedStack(
          index: _appViewModel.currentIndex.value,
          children: _appViewModel.categories['widget'].cast<Widget>(),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE4E4E7), width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_appViewModel.categories['icons'].length, (
              index,
            ) {
              return TextButton(
                onPressed: () {
                  _appViewModel.loadTab(index);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  foregroundColor: _appViewModel.currentIndex.value == index
                      ? Color(0xFF7C3AED)
                      : Colors.grey,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_appViewModel.categories['icons'][index], size: 24),
                    SizedBox(height: 4),
                    Text(_appViewModel.categories['label'][index]),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
