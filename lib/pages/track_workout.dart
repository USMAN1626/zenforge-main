import 'package:flutter/material.dart';
import 'dart:async';
import 'package:zenforge/pages/timer_popup.dart';
import 'package:zenforge/pages/bookings.dart';
import 'package:zenforge/pages/homepage.dart';
import 'package:zenforge/pages/bottom_navbar.dart';
import 'package:zenforge/pages/workout_plans.dart';
import 'package:zenforge/pages/diet_plan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackWorkout extends StatefulWidget {
  @override
  _TrackWorkoutState createState() => _TrackWorkoutState();
}

class _TrackWorkoutState extends State<TrackWorkout> {
  List<int> weeklyProgress = List.filled(7, 0);

  Map<String, int> exerciseCounts = {
    'Upper Body Workout': 5,
    'Lower Body Workout': 4,
    'Abs and Mid Body': 6,
  };
  Map<String, int> exercisesCompleted = {
    'Upper Body Workout': 0,
    'Lower Body Workout': 0,
    'Abs and Mid Body': 0,
  };

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkoutPlans()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BookingsPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DietPlan()),
      );
    } else if (index == 4) {
      // Same page do nothing
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProgressData();
  }

  Future<void> _fetchProgressData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('progress')
          .doc('days')
          .get();
      if (snapshot.exists) {
        setState(() {
          weeklyProgress = List<int>.from(snapshot['weeklyProgress']);
        });
      }
    } catch (e) {
      print("Error fetching progress data: $e");
    }
  }

  Future<void> _updateProgressForCurrentDay(int progress) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('progress')
          .doc('days')
          .get();
      if (snapshot.exists) {
        List<int> currentProgress = List<int>.from(snapshot['weeklyProgress']);
        int currentDayIndex =
            DateTime.now().weekday - 1; // Monday is 0, Sunday is 6
        currentProgress[currentDayIndex] = progress;

        await FirebaseFirestore.instance
            .collection('progress')
            .doc('days')
            .update({'weeklyProgress': currentProgress});

        setState(() {
          weeklyProgress = currentProgress;
        });

        print("Progress data updated successfully");
      }
    } catch (e) {
      print("Error updating progress data: $e");
    }
  }

  void _showPopup(String workoutType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (workoutType == 'Upper Body Workout') {
          return _buildUpperBodyWorkoutPopup('Upper Body Workout', 5);
        } else if (workoutType == 'Lower Body Workout') {
          return _buildLowerBodyWorkoutPopup('Lower Body Workout', 4);
        } else if (workoutType == 'Abs and Mid Body') {
          return _buildAbsAndMidBodyWorkoutPopup('Abs and Mid Body', 6);
        }
        return Container(); // Placeholder
      },
    );
  }

  Widget _buildUpperBodyWorkoutPopup(String workoutType, int exerciseCount) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          workoutType.toUpperCase(),
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
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildWorkoutItem(
                      'PUSH UPS', '3 Sets of 8-10 Reps', 300, workoutType),
                  _buildWorkoutItem(
                      'PULL UPS', '3 Sets of 5-8 Reps', 300, workoutType),
                  _buildWorkoutItem('SHOULDER PRESS', '3 Sets of 8-10 Reps',
                      300, workoutType),
                  _buildWorkoutItem(
                      'DUMBELL ROWS', '2 Sets of 8-10 Reps', 180, workoutType),
                  _buildWorkoutItem(
                      'BICEP CURLS', '2 Sets of 10-12 Reps', 120, workoutType),
                  SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLowerBodyWorkoutPopup(String workoutType, int exerciseCount) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          workoutType.toUpperCase(),
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
                  _buildWorkoutItem(
                      'SQUATS', '3 Sets of 8-10 Reps', 300, workoutType),
                  _buildWorkoutItem(
                      'LUNGES', '3 Sets of 10-12 Reps', 300, workoutType),
                  _buildWorkoutItem(
                      'LEG PRESS', '3 Sets of 8-10 Reps', 300, workoutType),
                  _buildWorkoutItem(
                      'CALF RAISES', '3 Sets of 12-15 Reps', 180, workoutType),
                  SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAbsAndMidBodyWorkoutPopup(
      String workoutType, int exerciseCount) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          workoutType.toUpperCase(),
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
                  _buildWorkoutItem(
                      'CRUNCHES', '3 Sets of 15-20 Reps', 180, workoutType),
                  _buildWorkoutItem(
                      'PLANK', '3 Sets of 60 Sec', 180, workoutType),
                  _buildWorkoutItem(
                      'BRIDGE', '3 Sets of 15-20 Reps', 180, workoutType),
                  _buildWorkoutItem(
                      'LEG RAISES', '3 Sets of 15-20 Reps', 180, workoutType),
                  _buildWorkoutItem('RUSSIAN TWISTS', '3 Sets of 20-30 Reps',
                      180, workoutType),
                  _buildWorkoutItem(
                      'SIT-UPS', '3 Sets of 30 Sec', 180, workoutType),
                  SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWorkoutItem(
      String title, String sets, int duration, String workoutType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sets,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                '${(duration / 60).floor()}:${(duration % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
            ),
            onPressed: () {
              _showTimerPopup(context, duration);
              _incrementExerciseCount(workoutType);
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }

  void _showTimerPopup(BuildContext context, int duration) {
    showDialog(
      context: context,
      barrierDismissible: false, // Makes the dialog non-dismissible
      builder: (BuildContext context) {
        return TimerPopup(duration: duration);
      },
    );
  }

  void _incrementExerciseCount(String workoutType) {
    setState(() {
      int? completed = exercisesCompleted[workoutType];
      int? total = exerciseCounts[workoutType];
      if (completed != null && total != null && completed < total) {
        exercisesCompleted[workoutType] = completed + 1;
        _updateWeeklyProgress();
      }
    });
  }

  void _updateWeeklyProgress() {
    int currentDay = DateTime.now().weekday - 1;
    int totalExercises =
        exerciseCounts.values.fold(0, (sum, count) => sum + (count));
    int completedExercises =
        exercisesCompleted.values.fold(0, (sum, count) => sum + (count));

    setState(() {
      if (totalExercises > 0) {
        weeklyProgress[currentDay] =
            ((completedExercises / totalExercises) * 100).toInt();
      }
      _updateProgressForCurrentDay(weeklyProgress[currentDay]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/images/workout_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Back Button
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              Center(
                child: Text(
                  'Track Your Workout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildVerticalProgressBars(),
                        SizedBox(height: 20),
                        _buildWorkoutOptionCard(
                            'Upper Body Workout', '5 Exercises | 20 Minutes'),
                        _buildWorkoutOptionCard(
                            'Lower Body Workout', '4 Exercises | 15 Minutes'),
                        _buildWorkoutOptionCard(
                            'Abs and Mid Body', '6 Exercises | 25 Minutes'),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Use BottomNavBar widget
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              initialIndex: 4, // Index of Workout Plans on navbar
              onItemTapped: _onItemTapped, // Handle navigation
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalProgressBars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 200,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: (weeklyProgress[index] / 100.0) * 200,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _getDayName(index),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return 'MON';
      case 1:
        return 'TUE';
      case 2:
        return 'WED';
      case 3:
        return 'THU';
      case 4:
        return 'FRI';
      case 5:
        return 'SAT';
      case 6:
        return 'SUN';
      default:
        return '';
    }
  }

  Widget _buildWorkoutOptionCard(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.black.withOpacity(0.8),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.white70),
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
            ),
            onPressed: () {
              _showPopup(title);
            },
            child: Text(
              'View More',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
