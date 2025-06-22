import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // false = GET STARTED putih, true = LOGIN putih
  bool isLoginButtonActive = false;

  @override
  void initState() {
    super.initState();
    _loadLastButtonState();
  }

  Future<void> _loadLastButtonState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoginButtonActive = prefs.getBool('isLoginButtonActive') ?? false;
    });
  }

  Future<void> _saveLastButtonState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoginButtonActive', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Hero(
              tag: 'logo_kodein',
              child: Image.asset('assets/logos/logo.png', width: 120, height: 120),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Belajar programming dengan mudah & menyenangkan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // GET STARTED BUTTON
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          isLoginButtonActive
                              ? Colors.transparent
                              : Colors.white,
                      foregroundColor:
                          isLoginButtonActive ? Colors.white : Colors.blue,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoginButtonActive = false;
                      });
                      await _saveLastButtonState(false);
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: isLoginButtonActive ? Colors.white : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // I ALREADY HAVE AN ACCOUNT BUTTON
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          isLoginButtonActive
                              ? Colors.white
                              : Colors.transparent,
                      foregroundColor:
                          isLoginButtonActive ? Colors.blue : Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoginButtonActive = true;
                      });
                      await _saveLastButtonState(true);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'I ALREADY HAVE AN ACCOUNT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 1,
                        color: isLoginButtonActive ? Colors.blue : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
