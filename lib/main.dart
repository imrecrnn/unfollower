import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'services/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'UnFollower',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 1600), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen(appTitle: 'UnFollower')),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/app_icon.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 32),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFFF58529),
                      Color(0xFFDD2A7B),
                      Color(0xFF8134AF),
                      Color(0xFF515BD4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: const Text(
                  'UnFollower',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 