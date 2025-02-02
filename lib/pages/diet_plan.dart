import 'package:flutter/material.dart';
import 'package:zenforge/pages/homepage.dart';
import 'package:zenforge/pages/track_workout.dart';
import 'package:zenforge/pages/workout_plans.dart';
import 'package:zenforge/pages/bookings.dart';
import 'bottom_navbar.dart';

class DietPlan extends StatefulWidget {
  @override
  _DietPlanState createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  bool isBreakfastExpanded = false;
  bool isLunchExpanded = false;
  bool isDinnerExpanded = false;

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
      // Same page do nothing
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
          Image.asset(
            'assets/images/diet plan bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
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
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Diet Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildExpandableContainer(
                          'BREAKFAST',
                          468,
                          447,
                          isBreakfastExpanded,
                          () {
                            setState(() {
                              isBreakfastExpanded = !isBreakfastExpanded;
                            });
                          },
                          [
                            _buildDietItem('150 Grams of Yogurt', 222),
                            _buildDietItem('30 Grams of Oats', 126),
                            _buildDietItem('Medium-Sized Apple', 72),
                          ],
                        ),
                        SizedBox(height: 25),
                        _buildExpandableContainer(
                          'LUNCH',
                          540,
                          530,
                          isLunchExpanded,
                          () {
                            setState(() {
                              isLunchExpanded = !isLunchExpanded;
                            });
                          },
                          [
                            _buildDietItem('150 Grams of Boiled Chicken', 270),
                            _buildDietItem('70 Grams of salad', 190),
                            _buildDietItem('Some Oranges', 80),
                          ],
                        ),
                        SizedBox(height: 25),
                        _buildExpandableContainer(
                          'DINNER',
                          492,
                          480,
                          isDinnerExpanded,
                          () {
                            setState(() {
                              isDinnerExpanded = !isDinnerExpanded;
                            });
                          },
                          [
                            _buildDietItem('120 Grams of Fish', 313),
                            _buildDietItem('100 Grams of Broccoli', 64),
                            _buildDietItem('100 Grams of Sweet Potatoes', 115),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
          // Use BottomNavBar widget
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              initialIndex: 3, // Index of Workout Plans on navbar
              onItemTapped: _onItemTapped, // Handle navigation
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableContainer(
      String title,
      int currentKal,
      int recommendedKcal,
      bool isExpanded,
      VoidCallback onPressed,
      List<Widget> items) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          onPressed();
        },
        expandedHeaderPadding: EdgeInsets.all(10),
        elevation: 1,
        children: [
          ExpansionPanel(
            isExpanded: isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  '$title $currentKal kcal',
                  style: TextStyle(
                    color: Colors.amber[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text('Recommended $recommendedKcal kcal'),
              );
            },
            body: Column(
              children: items,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietItem(String name, int kcal) {
    return ListTile(
      title: Text(name),
      trailing: Text('$kcal kcal'),
    );
  }
}
