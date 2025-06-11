import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/bmi_screen.dart';

void main() => runApp(FitnessTrackerApp());

class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker', // App title
      debugShowCheckedModeBanner: false, // Hide debug banner in top-right corner
      theme: ThemeData(primarySwatch: Colors.deepPurple), // Main theme color (purple)
      home: NavigationWrapper(), // Starting widget for the app
    );
  }
}

// This widget manages the bottom navigation and screen switching
class NavigationWrapper extends StatefulWidget {
  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0; // Keeps track of currently selected tab index

  // This list stores workout entries as maps with details like title, category, duration, date
  final List<Map<String, dynamic>> _workouts = [];

  // Called when a new workout is added, updates the state to refresh UI
  void _addWorkout(Map<String, dynamic> workout) {
    setState(() {
      _workouts.add(workout);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of screens for bottom navigation tabs
    final screens = [
      HomeScreen(
        workouts: _workouts, // Pass the list of workouts to home screen
        onAddWorkout: _addWorkout, // Pass function to add new workout
      ),
      ProgressScreen(workouts: _workouts), // Progress screen gets workouts to display stats
      BMIScreen(), // BMI screen is independent, no workout data needed
    ];

    return Scaffold(
      body: screens[_currentIndex], // Show the currently selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the selected tab
        selectedItemColor: Colors.deepPurple, // Color for selected tab icon and text
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        onTap: (index) => setState(() => _currentIndex = index), // Update selected tab index on tap
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), // Home tab
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'), // Progress tab
          BottomNavigationBarItem(icon: Icon(Icons.monitor_weight), label: 'BMI'), // BMI tab
        ],
      ),
    );
  }
}
