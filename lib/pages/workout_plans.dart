import 'package:flutter/material.dart';
import 'package:zenforge/pages/bookings.dart';
import 'package:zenforge/pages/diet_plan.dart';
import 'package:zenforge/pages/homepage.dart';
import 'package:zenforge/pages/track_workout.dart';
import 'dart:ui';
import 'bottom_navbar.dart';

class WorkoutPlans extends StatefulWidget {
  @override
  _WorkoutPlansState createState() => _WorkoutPlansState();
}
class _WorkoutPlansState extends State<WorkoutPlans> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 0) {
      // Same page do nothing
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrackWorkout()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Image.asset(
              'assets/images/wplans.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Back Button
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80),
              Center(
                child: Text(
                  'Workout Plans',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(0, 'Beginner'),
                  _buildButton(1, 'Intermediate'),
                  _buildButton(2, 'Advanced'),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: _buildWorkoutCards(),
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
              initialIndex: 0, // Index of Workout Plans on navbar
              onItemTapped: _onItemTapped, // Handle navigation
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(int index, String title) {
    Color color =
        _selectedIndex == index ? Color(0xFFFBBC05) : Color(0xFF313131);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> _buildWorkoutCards() {
    List<Widget> cards = [];
    // Depending on the selected index different cards can be shown
    if (_selectedIndex == 0) {
      // Beginner workouts
      cards.addAll([
        _buildWorkoutCard('Pushups', 'assets/images/w_plans/wp1.jpg',
            'Reps: 10-12', 'Sets: 2'),
        _buildWorkoutCard('Leg Press', 'assets/images/w_plans/wp2.jpg',
            'Reps: 10-12', 'Sets: 3'),
        _buildWorkoutCard('Planks', 'assets/images/w_plans/wp3.png',
            'Time: 30-40 secs', 'Sets: 3'),
        _buildWorkoutCard('Leg Raises', 'assets/images/w_plans/wp4.jpg',
            'Reps: 10-12', 'Sets: 3'),
        _buildWorkoutCard('Dumbbell Rows', 'assets/images/w_plans/wp5.jpg',
            'Reps: 10-12', 'Sets: 3'),
      ]);
    } else if (_selectedIndex == 1) {
      // Intermediate workouts
      cards.addAll([
        _buildWorkoutCard('Pushups', 'assets/images/w_plans/wp4.jpg',
            'Reps: 12-15', 'Sets: 3'),
        _buildWorkoutCard('Leg Press', 'assets/images/w_plans/wp3.png',
            'Reps: 12-15', 'Sets: 3'),
        _buildWorkoutCard('Planks', 'assets/images/w_plans/wp5.jpg',
            'Time: 40-50 secs', 'Sets: 3'),
        _buildWorkoutCard('Leg Raises', 'assets/images/w_plans/wp1.jpg',
            'Reps: 12-15', 'Sets: 3'),
        _buildWorkoutCard('Dumbbell Rows', 'assets/images/w_plans/wp2.jpg',
            'Reps: 12-15', 'Sets: 3'),
      ]);
    } else {
      // Advanced workouts
      cards.addAll([
        _buildWorkoutCard('Pushups', 'assets/images/w_plans/wp3.png',
            'Reps: 15-20', 'Sets: 4'),
        _buildWorkoutCard('Leg Press', 'assets/images/w_plans/wp5.jpg',
            'Reps: 15-20', 'Sets: 4'),
        _buildWorkoutCard('Planks', 'assets/images/w_plans/wp1.jpg',
            'Time: 50-60 secs', 'Sets: 4'),
        _buildWorkoutCard('Leg Raises', 'assets/images/w_plans/wp2.jpg',
            'Reps: 15-20', 'Sets: 4'),
        _buildWorkoutCard('Dumbbell Rows', 'assets/images/w_plans/wp4.jpg',
            'Reps: 15-20', 'Sets: 4'),
      ]);
    }
    return cards;
  }

  Widget _buildWorkoutCard(
      String title, String imagePath, String info1, String info2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.2), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      info1,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      info2,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
