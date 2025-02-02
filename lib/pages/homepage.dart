import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zenforge/pages/login.dart';
import 'package:zenforge/pages/track_workout.dart';
import 'package:zenforge/pages/workout_plans.dart';
import 'package:zenforge/pages/bookings.dart';
import 'package:zenforge/pages/diet_plan.dart';
import 'bottom_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String username = 'Usman';

  void _onItemTapped(int index) {
    // Navigate to different pages based on the selected index
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
      // Same page do nothing
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
      endDrawer: appDrawer(context),
      body: Builder(
        builder: (context) => Stack(
          children: [
            // Background image
            backgroundImage(),

            // Back Button
            // backButton(context),

            // Avatar with menu opener
            drawerOpener(context),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // display title
                pageTitle(),

                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    children: [
                      buildCard(context, 'Workout Plans',
                          'assets/images/Workout Plan.png'),
                      SizedBox(height: 20),
                      buildCard(context, 'Book Your Slot!',
                          'assets/images/Book Slot.png'),
                      SizedBox(height: 20),
                      buildCard(context, 'Get Diet Plan',
                          'assets/images/diet plan.png'),
                      SizedBox(height: 20),
                      buildCard(context, 'Track Your Workout',
                          'assets/images/Track Workout.png'),
                      SizedBox(height: 100),
                    ],
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
                initialIndex: 2, // Set the initial index
                onItemTapped: _onItemTapped, // Handle navigation
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget backgroundImage() {
  return ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: Image.asset(
      'assets/images/homepage_bg.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  );
}

Widget backButton(BuildContext context) {
  return Positioned(
    top: 3,
    left: 3,
    child: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

Widget drawerOpener(BuildContext context) {
  return Positioned(
    top: 10,
    right: 20,
    child: GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey[400],
        child: const Icon(Icons.person),
      ),
    ),
  );
}

Widget pageTitle() {
  return Column(
    children: [
      SizedBox(height: 100),
      Text(
        'Welcome',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Start Your Journey',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ],
  );
}

Widget buildCard(BuildContext context, String title, String imagePath) {
  return GestureDetector(
    onTap: () {
      if (title == 'Workout Plans') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkoutPlans()),
        );
      } else if (title == 'Book Your Slot!') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingsPage()),
        );
      } else if (title == 'Get Diet Plan') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietPlan()),
        );
      } else if (title == 'Track Your Workout') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackWorkout()),
        );
      }
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100,
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget appDrawer(BuildContext context) {
  return Drawer(
    width: 250,
    child: Stack(
      // Used Stack for positioning the footer
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFBBC05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CircleAvatar(
                      radius: 30,
                      // backgroundColor: Colors.grey[400],
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFFFBBC05),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text('Workout Plans'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutPlans()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Bookings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text('Diet Plans'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DietPlan()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Track Your Workout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrackWorkout()),
                );
              },
            ),
          ],
        ),
        // Positioned footer at bottom
        Positioned(
          bottom: 10.0,
          left: 0.0,
          right: 0.0,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
              Text(
                'App Version: 1.0.0',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[800]),
              ),
              Text(
                '© 2025 by Muhammad Usman',
                style: TextStyle(fontSize: 12.0, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
