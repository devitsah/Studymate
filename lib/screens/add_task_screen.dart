import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/study_task.dart';
import '../providers/task_provider.dart'; 
import '../services/notification_service.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});
  
  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final subjectCtrl = TextEditingController();
  final topicCtrl = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    subjectCtrl.dispose();
    topicCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Study Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subjectCtrl,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: topicCtrl,
              decoration: const InputDecoration(
                labelText: 'Topic',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.topic),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_today),
              label: Text(
                selectedDate == null
                    ? 'Pick Due Date'
                    : 'Due: ${selectedDate!.toLocal().toString().split(" ")[0]}',
              ),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Task'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  if (subjectCtrl.text.isEmpty ||
                      topicCtrl.text.isEmpty ||
                      selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  final task = StudyTask(
                    subject: subjectCtrl.text,
                    topic: topicCtrl.text,
                    dueDate: selectedDate!,
                  );

                  ref.read(taskProvider.notifier).addTask(task);

                  // Schedule notification 2 hours before due date
                  final reminderTime = selectedDate!.subtract(const Duration(hours: 2));
                  if (reminderTime.isAfter(DateTime.now())) {
                    NotificationService.scheduleTaskNotification(
                      title: 'Study Reminder: ${subjectCtrl.text}',
                      body: 'Time to study "${topicCtrl.text}"!',
                      scheduledDate: reminderTime,
                    );
                  }

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}