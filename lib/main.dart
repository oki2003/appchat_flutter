import 'package:appchat_flutter/core/overlay/loading_overlay.dart';
import 'package:appchat_flutter/features/app/app.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/features/auth/login_screen.dart';
import 'package:appchat_flutter/features/auth/register_screen.dart';
import 'package:appchat_flutter/features/auth/splash_screen.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:appchat_flutter/core/overlay/toast_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initLocalStorage();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ToastOverlay.init(navigatorKey);
      LoadingOverlay.init(navigatorKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..auth(),
      child: SafeArea(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFEFECF8)),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
              ),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Color(0xFF7C3AED),
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
              titleMedium: const TextStyle(
                color: Color(0xFF7C3AED),
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              titleSmall: const TextStyle(
                color: Color(0xFF7C3AED),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            inputDecorationTheme: InputDecorationThemeData(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintStyle: TextStyle(color: Color(0xFF828485)),
              filled: true,
              hoverColor: Color(0xFFE7E8EB),
              fillColor: Color(0xFFE7E8EB),
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
            "/": (context) => SplashScreen(),
            "/app": (context) => App(),
            "/login": (context) => LoginScreen(),
            "/register": (context) => RegisterScreen(),
          },
        ),
      ),
    );
  }
}
