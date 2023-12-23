import 'package:flutter/material.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/providers/task_provider.dart';
import 'package:flutterdoo/screens/pages/home_page.dart';
import 'package:provider/provider.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final List<String> priorities = ["HIGH", "MEDIUM", "LOW"];
  late String selectedPriority = "HIGH";

  DateTime? selectedDueDate;

  @override
  Widget build(BuildContext context) {
    bool isSaveButtonEnabled = titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        selectedPriority.isNotEmpty &&
        selectedDueDate != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.2),
        centerTitle: true,
        title: Text("FlutterDoo"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField("Title", titleController),
            SizedBox(height: 16),
            _buildTextField("Description", descriptionController, maxLines: 3),
            SizedBox(height: 16),
            _buildDropdownButton("Priority", priorities, selectedPriority,
                (String? value) {
              setState(() {
                selectedPriority = value!;
              });
            }),
            SizedBox(height: 16),
            _buildDatePicker("Due Date", selectedDueDate, (DateTime? date) {
              setState(() {
                selectedDueDate = date;
              });
            }),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: isSaveButtonEnabled
                  ? () async {
                      Task task = Task(
                          id: DateTime.now().millisecondsSinceEpoch,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          title: titleController.text,
                          description: descriptionController.text,
                          dueDate: selectedDueDate!.millisecondsSinceEpoch,
                          priority: selectedPriority,
                          isCompleted: 0);
                      await Provider.of<TaskProvider>(context,listen: false).addTasks(task);
                      Navigator.pop(context);
                    }
                  : null,
              color: Colors.greenAccent,
              // Change to greenAccent color
              elevation: 0,
              // Set elevation to 0
              padding: EdgeInsets.symmetric(vertical: 16),
              disabledColor: Colors.grey,
              child: Text(
                "Save Task",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black), // Change text color to black
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdownButton(
    String label,
    List<String> items,
    String selectedItem,
    void Function(String? value) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: selectedItem,
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              child: Text(e),
              value: e,
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate,
      void Function(DateTime? date) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        MaterialButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != selectedDate) {
              onChanged(pickedDate);
            }
          },
          color: Colors.greenAccent, // Change to greenAccent color
          child: Text(
            selectedDate != null
                ? "${selectedDate.toLocal().day}/${selectedDate.toLocal().month}/${selectedDate.toLocal().year}"
                : "Select Date",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black), // Change text color to black
          ),
        ),
      ],
    );
  }
}
