import 'package:flutter/material.dart';

import 'Authentication screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routName="Splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _positionAnimation = Tween<double>(
      begin: -1.0, // Move from the top
      end: 0.0, // Move to the center
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation after the widget is built
    _animationController.forward();

    // Navigate to the next screen after animation completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Animated Image
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: Offset(
                    0.0,
                    MediaQuery.of(context).size.height *
                        _positionAnimation.value,
                  ),
                  child: child,
                ),
              );
            },
            child: Image.asset(
              'assets/images/logo.png',
              height: 200.0, // Adjust the height as needed
              width: 200.0, // Adjust the width as needed
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
