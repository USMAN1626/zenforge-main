import 'package:flutter/material.dart';
// import 'package:zenforge/pages/homepage.dart';
import 'dart:async';
import 'package:zenforge/pages/login.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xe4000000), // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  // stroked text outline
                  Text(
                    'Zen Forge',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 8
                        ..color = Colors.amber[600]!,
                    ),
                  ),
                  // normal text
                  Text(
                    'Zen Forge',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[600]!),
                strokeWidth: 4.0,
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
