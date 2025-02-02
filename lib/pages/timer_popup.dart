import 'package:flutter/material.dart';
import 'dart:async';

class TimerPopup extends StatefulWidget {
  final int duration;

  TimerPopup({required this.duration});

  @override
  _TimerPopupState createState() => _TimerPopupState();
}

class _TimerPopupState extends State<TimerPopup> {
  late int _currentTimer;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTimer = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimer > 0) {
          _currentTimer--;
        } else {
          _timer.cancel();
          Navigator.of(context).pop(true); // Return true when timer ends
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Workout Timer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '${(_currentTimer / 60).floor()}:${(_currentTimer % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Center(
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.yellow,
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('Close'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
