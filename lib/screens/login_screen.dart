import 'package:flutter/material.dart';
import 'main_page.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class LoginScreen extends StatefulWidget {
  final String appTitle;
  const LoginScreen({Key? key, required this.appTitle}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loginWithInstagram(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF58529), // turuncu
              Color(0xFFDD2A7B), // pembe
              Color(0xFF8134AF), // mor
              Color(0xFF515BD4), // mavi
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _isLoading
                ? ScaleTransition(
                    scale: _animation,
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 120,
                      height: 120,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/app_icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        widget.appTitle,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Instagram ile giriş yaparak takipçi analizlerini keşfet!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.login, color: Colors.white),
                        label: const Text(
                          'Instagram ile Giriş Yap',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDD2A7B),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        onPressed: () => _loginWithInstagram(context),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
} 