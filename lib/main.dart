import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/splash/view/splash_page.dart';
import 'features/auth/view/login_page.dart';
import 'features/auth/view/register_page.dart';
import 'features/home/view/home_page.dart';
import 'features/profile/view/profile_page.dart';
import 'features/courses/view/courses_page.dart';
import 'features/welcome/view/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MainScaffold(),
        '/profile': (context) => const ProfilePage(),
        '/courses': (context) => const CoursesPage(),
      },
    );
  }
}
