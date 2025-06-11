class Workout {
  final String title;      // Name of the workout, e.g., "Push Ups"
  final String category;   // Category or type, e.g., "Strength"
  final int duration;      // Duration in minutes, e.g., 30
  final DateTime date;     // Date when the workout was done

  Workout({
    required this.title,
    required this.category,
    required this.duration,
    required this.date,
  });
}
