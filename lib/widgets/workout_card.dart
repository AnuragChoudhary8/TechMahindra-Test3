import 'package:flutter/material.dart';
import '../models/workout.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Outer spacing around the card
      elevation: 6, // Shadow depth for the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Rounded corners on card
      color: Colors.deepPurple.shade50, // Light purple background color for card
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Inner padding inside the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center vertically all children in the row
          children: [
            // Circle avatar with fitness icon
            CircleAvatar(
              radius: 28, // Size of the circle avatar
              backgroundColor: Colors.deepPurple.shade100, // Light purple background for avatar
              child: const Icon(Icons.fitness_center, color: Colors.deepPurple), // Fitness icon with dark purple color
            ),
            const SizedBox(width: 16), // Space between avatar and text column

            // Text details about workout (title, category & duration)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to left inside column
                children: [
                  // Workout title
                  Text(
                    workout.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 6), // Space between title and category/duration

                  // Workout category and duration
                  Text(
                    '${workout.category} • ${workout.duration} mins',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10), // Space between text column and date

            // Date formatted with intl package (e.g. "Jun 9, 2025")
            Text(
              DateFormat.yMMMd().format(workout.date),
              style: TextStyle(
                fontSize: 12,
                color: Colors.deepPurple.shade400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
