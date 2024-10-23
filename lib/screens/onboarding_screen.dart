// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const OnboardingPage(
            image: 'assets/images/bg1.jpg', 
            title: 'Welcome',
            description: 'Welcome to our app. Here you will find great features to help you.',
          ),
          const OnboardingPage(
            image: 'assets/images/bg2.jpg', 
            title: 'Discover',
            description: 'Discover new features and stay connected with the community.',
          ),
          OnboardingPage(
            image: 'assets/images/bg3.jpg', 
            title: 'Get Started',
            description: 'Let\'s get started! Enjoy using our app.',
            isLastPage: true,
            onStart: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback? onStart;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    this.isLastPage = false,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20.0),
          if (isLastPage)
            ElevatedButton(
              onPressed: onStart,
              child: const Text('Get Started'),
            ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
