import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopimgPage extends StatefulWidget {
  @override
  State<TopimgPage> createState() => _TopimgPageState();
}

class _TopimgPageState extends State<TopimgPage> {
  final List<String> images = [
    'assets/images/splash.webp',
    'assets/images/off1.jpg',
    'assets/images/off2.jpg',
    'assets/images/off3.webp',
    'assets/images/off4.jpg',
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: Container(
            key: ValueKey<String>(images[_currentIndex]),
            height: 500,
            width: double.infinity,
            child: Image.asset(
              images[_currentIndex],
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        ),
      ],
    );
  }
}
