# Fitness Tracker App

A simple and clean **Flutter** app to track your workouts, monitor progress, and calculate BMI.

---

## Project Description

The Fitness Tracker App helps users log their daily workouts with details such as title, category, duration, and date. It provides a home screen to view today's workouts, a progress screen visualizing workout summaries and durations, and a BMI calculator to assess the user's body mass index. The app uses a smooth and modern UI with Flutter's Material design components and the `fl_chart` package for graphical representations.

---

## Features

- **Add Workouts:** Log workouts with title, category, duration, and date.
- **Today's Activity:** View workouts logged for the current day on the home screen.
- **Progress Visualization:** Bar charts and summary chips to visualize workouts per category and workout durations over time.
- **BMI Calculator:** Calculate Body Mass Index (BMI) based on weight and height input.
- **Clean UI:** Responsive, user-friendly, and intuitive interface with Flutter widgets and Material Design.
- **State Management:** Simple state management with StatefulWidgets passing data via constructors and callbacks.
- **Navigation:** Bottom navigation bar to switch between Home, Progress, and BMI screens.

---

## Screens

1. **Home Screen**  
   Displays today's workout activities and allows quick addition of new workouts.

2. **Progress Screen**  
   Visualizes the number of workouts per category and duration of each workout using bar charts.

3. **BMI Screen**  
   Simple BMI calculator where users input weight (kg) and height (cm) to get BMI and health status.

---

## Folder Structure

fitness_app/
├── main.dart                          # Entry point of the Flutter application
│
├── models/
│   └── workout.dart                   # Model class for workout data
│
├── screens/
│   ├── home_screen.dart               # Home screen with today's activities
│   ├── progress_screen.dart           # Progress visualization (charts/stats)
│   ├── bmi_screen.dart                # BMI calculator screen
│   └── add_workout_screen.dart        # Form to add a new workout
│
├── widgets/
│   └── workout_card.dart              # Reusable card widget for workouts




## Dependencies

- `flutter` (SDK)
- `fl_chart` (for charts visualization)
- `intl` (for date formatting)

---

## Getting Started

1. Clone the repository : by copying the Url and write the Command

    git clone 'url'

3. Navigate to the project Directory

    cd fitness_app

5. Install Dependencies by this Command
   
    flutter pub get

7. Run project by this Command
   
    flutter run 
