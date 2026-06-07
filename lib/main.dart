import 'package:appchat_flutter/core/overlay/loading_overlay.dart';
import 'package:appchat_flutter/features/app/app.dart';
import 'package:appchat_flutter/features/auth/cubit/auth_cubit.dart';
import 'package:appchat_flutter/features/auth/login_screen.dart';
import 'package:appchat_flutter/features/auth/register_screen.dart';
import 'package:appchat_flutter/features/auth/splash_screen.dart';
import 'package:appchat_flutter/services/local_storage.dart';
import 'package:appchat_flutter/core/overlay/toast_overlay.dart';
import 'package:appchat_flutter/theme/brand_theme.dart';
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
  bool isDarkMode = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ToastOverlay.init(navigatorKey);
      LoadingOverlay.init(navigatorKey);
    });
    super.initState();
  }

  void onChangedMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BrandAppTheme brandAppTheme = BrandAppTheme(context: context);
    return BlocProvider(
      create: (context) => AuthCubit()..auth(),
      child: SafeArea(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandAppTheme.primaryBrandColor,
                foregroundColor: brandAppTheme.textColor,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: brandAppTheme.primaryBrandColor,
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
              titleMedium: TextStyle(
                color: brandAppTheme.primaryBrandColor,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              titleSmall: TextStyle(
                color: brandAppTheme.primaryBrandColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            inputDecorationTheme: InputDecorationThemeData(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintStyle: TextStyle(color: brandAppTheme.noteBrandColor),
              filled: true,
              hoverColor: brandAppTheme.backgroundInputBrandColor,
              fillColor: brandAppTheme.backgroundInputBrandColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: brandAppTheme.borderBrandColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: brandAppTheme.borderBrandColor),
              ),
            ),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: '/',
          routes: {
            "/": (context) => SplashScreen(),
            "/app": (context) => App(onChangedMode: () => onChangedMode()),
            "/login": (context) => LoginScreen(),
            "/register": (context) => RegisterScreen(),
          },
        ),
      ),
    );
  }
}
