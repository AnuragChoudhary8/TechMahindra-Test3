import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  // Controllers to get user input for weight and height
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  // Variables to hold calculated BMI value and status message
  double? _bmi;
  String _status = "";

  // Function to calculate BMI when user taps the button
  void calculateBMI() {
    // Parse weight and height from text fields, default to 0 if invalid input
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double heightCm = double.tryParse(heightController.text) ?? 0;

    // Convert height from centimeters to meters for calculation
    final double heightM = heightCm / 100;

    // Prevent calculation if inputs are invalid or zero
    if (heightM <= 0 || weight <= 0) return;

    // Calculate BMI formula: weight (kg) / height (m)^2
    final double bmi = weight / (heightM * heightM);

    // Determine BMI category/status based on BMI value
    String status;
    if (bmi < 18.5) {
      status = "Underweight";
    } else if (bmi < 24.9) {
      status = "Normal";
    } else if (bmi < 29.9) {
      status = "Overweight";
    } else {
      status = "Obese";
    }

    // Update the UI with calculated BMI and status
    setState(() {
      _bmi = bmi;
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title
      appBar: AppBar(title: Text('BMI Calculator')),
      // Body with padding around the content
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Input field for weight in kilograms
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            // Input field for height in centimeters
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            SizedBox(height: 20),
            // Button that triggers BMI calculation
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            // Display BMI results only if BMI has been calculated
            if (_bmi != null)
              Column(
                children: [
                  // Show BMI value rounded to 1 decimal place
                  Text(
                    'BMI: ${_bmi!.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Show BMI status/category
                  Text(
                    'Status: $_status',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
