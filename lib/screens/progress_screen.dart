import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends StatelessWidget {
  // List of workouts passed from parent to display progress
  final List<Map<String, dynamic>> workouts;

  const ProgressScreen({Key? key, required this.workouts}) : super(key: key);

  // Counts how many workouts belong to each category
  Map<String, int> getCategoryCounts() {
    final Map<String, int> counts = {};
    for (var workout in workouts) {
      final category = workout['category'] as String;
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  // Creates bar groups for the bar chart representing workout durations
  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> groups = [];
    for (int i = 0; i < workouts.length; i++) {
      final workout = workouts[i];
      final duration = (workout['duration'] as int).toDouble();

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: duration,                // Height of the bar (duration of workout)
              color: Colors.deepPurple,    // Bar color
              width: 16,                   // Bar width
              borderRadius: BorderRadius.circular(6), // Rounded corners for bars
            ),
          ],
        ),
      );
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    // Get count of workouts per category for summary chips
    final categoryCounts = getCategoryCounts();
    final categories = categoryCounts.keys.toList();

    // Calculate max Y-axis value for chart scaling (add some padding of 10)
    double maxY = 10;
    if (workouts.isNotEmpty) {
      maxY = workouts
              .map((w) => w['duration'] as int)
              .reduce((a, b) => a > b ? a : b)
              .toDouble() +
          10;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Column(
        children: [
          // Header row with title and icon
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Text("Your Workouts Summary", style: TextStyle(fontSize: 18)),
                Spacer(),
                Icon(Icons.show_chart),
              ],
            ),
          ),

          // Section displaying how many workouts per category as chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Workouts per Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  children: categories
                      .map((cat) => Chip(
                            label: Text("$cat: ${categoryCounts[cat]}"),
                            backgroundColor: Colors.deepPurple.shade100,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Title for the bar chart section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Workout Duration per Exercise",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Expanded widget for the bar chart to take remaining space
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BarChart(
                BarChartData(
                  maxY: maxY,                  // Max value on Y-axis
                  barGroups: getBarGroups(),   // The bars
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: true), // Enable bar tapping
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        // Display workout title truncated for better fit under bars
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index < 0 || index >= workouts.length) {
                            return const SizedBox.shrink();
                          }
                          String title = workouts[index]['title'] as String;
                          if (title.length > 10) {
                            title = "${title.substring(0, 10)}...";
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              title,
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 10),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 10), // Horizontal grid lines
                  borderData: FlBorderData(show: false),                     // Hide border lines
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
