import 'package:flutter/material.dart';
import 'package:zenforge/pages/track_workout.dart';
import 'package:zenforge/pages/workout_plans.dart';
import 'package:zenforge/pages/homepage.dart';
import 'package:zenforge/pages/diet_plan.dart';
import 'bottom_navbar.dart';

class Booking {
  String name;
  String email;
  DateTime bookingDate;
  TimeOfDay bookingTime;
  String selectedSlot;

  Booking({
    required this.name,
    required this.email,
    required this.bookingDate,
    required this.bookingTime,
    required this.selectedSlot,
  });
}

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<Booking> bookings = []; // List to store bookings

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkoutPlans()),
      );
    } else if (index == 1) {
      // Same page do nothing
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
      floatingActionButton: _addButton(),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bookings.jpg',
              fit: BoxFit.cover,
            ),
          ),

          /// Back Button
          Positioned(
            top: 5,
            left: 5,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Title
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Text(
              'Bookings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: bookings.isEmpty
                ? Center(
                    child: Text(
                      'Click + to reserve a booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(bookings[index].bookingDate.toString()),
                        background: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFBBC05),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) {
                          return _confirmDelete(
                              context); // Prompt user for confirmation
                        },
                        onDismissed: (direction) {
                          setState(() {
                            bookings
                                .removeAt(index); // Remove booking on dismiss
                          });
                        },
                        // Card that holds booking info
                        child: Card(
                          color: Color(0xFF313131),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Booking ${index + 1}',
                                  style: TextStyle(
                                    color: Color(0xFFFBBC05),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                _buildName('${bookings[index].name}'),
                                _buildEmail('${bookings[index].email}'),
                                _buildDate(
                                    '${bookings[index].bookingDate.day}/${bookings[index].bookingDate.month}/${bookings[index].bookingDate.year}'),
                                _buildTime(
                                    '${bookings[index].bookingTime.format(context)}'),
                                _buildSlot('${bookings[index].selectedSlot}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 100),
          // Use BottomNavBar widget
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(
              initialIndex: 1, // Index for Bookings on navbar
              onItemTapped: _onItemTapped, // Handle navigation
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton() {
    return Padding(
      padding: const EdgeInsets.only(
        // Adjust for BottomNavBar
        bottom: 70,
        right: 20,
      ),
      child: FloatingActionButton(
        backgroundColor: Color(0xFFFBBC05),
        onPressed: () {
          _showAddBookingDialog(); // Show add booking dialog
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Future<void> _showAddBookingDialog() async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedSlot = 'Morning';
    String name = '';
    String email = '';

    // Show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Booking',
            style: TextStyle(
              color: Color(0xffffc820),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.grey[200],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name TextField
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                // Email TextField
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                // Date picker
                ListTile(
                  title: Text('Date:'),
                  trailing: TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  ),
                ),
                // Time picker
                ListTile(
                  title: Text('Time:'),
                  trailing: TextButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (pickedTime != null && pickedTime != selectedTime) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Text(selectedTime.format(context)),
                  ),
                ),
                // Slot selection
                ListTile(
                  title: Text('Slot:'),
                  trailing: DropdownButton<String>(
                    value: selectedSlot,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSlot = newValue!;
                      });
                    },
                    items: <String>['Morning', 'Evening']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFFFBBC05), fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Add booking to the list
                  bookings.add(Booking(
                    name: name,
                    email: email,
                    bookingDate: selectedDate,
                    bookingTime: selectedTime,
                    selectedSlot: selectedSlot,
                  ));
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'Add',
                style: TextStyle(color: Color(0xFFFBBC05), fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) async {
    // Prompt user for confirmation before deleting booking
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Methods to display info on cards
  Widget _buildName(String name) {
    return Row(
      children: [
        Icon(
          Icons.person_outlined,
          color: Color(0xFFFBBC05),
        ),
        SizedBox(width: 10),
        Text(
          'Name: $name',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildEmail(String email) {
    return Row(
      children: [
        Icon(
          Icons.mail_outlined,
          color: Color(0xFFFBBC05),
        ),
        SizedBox(width: 10),
        Text(
          'Email: $email',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildDate(String date) {
    return Row(
      children: [
        Icon(
          Icons.date_range_outlined,
          color: Color(0xFFFBBC05),
        ),
        SizedBox(width: 10),
        Text(
          'Date: $date',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildTime(String time) {
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          color: Color(0xFFFBBC05),
        ),
        SizedBox(width: 10),
        Text(
          'Time: $time',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildSlot(String slot) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: Color(0xFFFBBC05),
        ),
        SizedBox(width: 10),
        Text(
          'Slot: $slot',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
