import 'package:appchat_flutter/views/chat_detail_screen.dart';
import 'package:appchat_flutter/views/login_screen.dart';
import 'package:appchat_flutter/views/navigation.dart';
import 'package:appchat_flutter/views/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFEFECF8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7851DE),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            color: Color(0xFF7851DE),
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
          titleMedium: const TextStyle(
            color: Color(0xFF7851DE),
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        inputDecorationTheme: InputDecorationThemeData(
          hintStyle: TextStyle(color: Color(0xFF71717A)),
          filled: true,
          hoverColor: Color(0xFFF9F9FA),
          fillColor: Color(0xFFF9F9FA),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFE4E4E7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFE4E4E7)),
          ),
        ),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => Navigation(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/chat_detail': (context) => ChatDetailScreen(),
      },
    );
  }
}
