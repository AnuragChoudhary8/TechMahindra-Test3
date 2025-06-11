import 'package:flutter/material.dart';
import 'AddWorkout_screen.dart';

class HomeScreen extends StatefulWidget {
  // List of workouts passed from parent to display and manage
  final List<Map<String, dynamic>> workouts;

  // Callback function to add a new workout from the AddWorkoutScreen
  final Function(Map<String, dynamic>) onAddWorkout;

  const HomeScreen({
    Key? key,
    required this.workouts,
    required this.onAddWorkout,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Navigate to AddWorkoutScreen and wait for the new workout to be returned
  void _goToWorkoutScreen() async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddWorkoutScreen(
          initialCategory: '',
        ),
      ),
    );

    // If user added a workout (did not cancel), call the callback to add it to the list
    if (newWorkout != null) {
      widget.onAddWorkout(newWorkout);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    // Filter workouts for those that belong to today (year, month, and day match)
    final todaysWorkouts = widget.workouts.where((w) {
      final d = w['date'] as DateTime;
      return d.year == today.year && d.month == today.month && d.day == today.day;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(" Fitness Tracker App "),
        backgroundColor: Colors.deepPurple,
      ),
      // Floating action button to add new workouts quickly
      floatingActionButton: FloatingActionButton(
        onPressed: _goToWorkoutScreen,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        tooltip: "Add New Workout",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting message at the top
              const Text(
                "👋 Hello, User",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Promotional banner encouraging user to join / motivate
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Build Your Best Body With Us",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: const Text("Join Now"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Header for Today's activity section with add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today Activity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: _goToWorkoutScreen,
                    icon: const Icon(Icons.add_circle, color: Colors.deepPurple),
                    tooltip: "Add Workout",
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Show a message if no workouts today
              if (todaysWorkouts.isEmpty)
                const Text("No activity today."),

              // List today's workouts dynamically
              ...todaysWorkouts.map(
                (w) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(w['title']),
                    subtitle: Text("${w['category']} - ${w['duration']} mins"),
                    trailing: Text(
                      // Display date as day/month
                      "${w['date'].day}/${w['date'].month}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
