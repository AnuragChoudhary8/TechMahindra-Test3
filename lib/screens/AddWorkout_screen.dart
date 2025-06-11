import 'package:flutter/material.dart';

class AddWorkoutScreen extends StatefulWidget {
  // Constructor takes an initialCategory (required), passed when screen is opened
  const AddWorkoutScreen({Key? key, required String initialCategory}) : super(key: key);

  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  // Form key to validate form inputs
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture text input values
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  // Variable to store the date picked by user
  DateTime? _selectedDate;

  // This method is called when the user taps the Save button
  void _submitForm() {
    // Validate form fields and check that date is chosen
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      // Normalize the selected date to remove time portion
      final normalizedDate = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      );

      // Create a map containing the workout data entered by user
      final newWorkout = {
        'title': _titleController.text,
        'category': _categoryController.text.trim(),
        'duration': int.parse(_durationController.text),
        'date': normalizedDate,
      };

      // Return the workout data back to the previous screen
      Navigator.pop(context, newWorkout);
    } else if (_selectedDate == null) {
      // Show a snackbar error if date wasn't chosen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please choose a date")),
      );
    }
  }

  // This function opens a date picker dialog and lets user pick a date
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // default date is today
      firstDate: DateTime(2000),   // earliest date selectable
      lastDate: DateTime(2100),    // latest date selectable
    );

    // Update the selected date state if a date was picked
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with screen title
      appBar: AppBar(title: const Text("Add Workout")),
      // Main form content with padding
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Assign the form key to enable validation
          child: Column(
            children: [
              // Text input for workout title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Workout Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter title' : null,
              ),

              const SizedBox(height: 10),

              // Text input for workout category
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Workout Category'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter category' : null,
              ),

              const SizedBox(height: 10),

              // Text input for duration in minutes (numeric keyboard)
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter duration' : null,
              ),

              const SizedBox(height: 16),

              // Row for displaying selected date and button to choose date
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _pickDate, // Open date picker when tapped
                    child: const Text("Choose Date"),
                  ),
                ],
              ),

              const Spacer(),

              // Button to save the workout after filling the form
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text("Save Workout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
