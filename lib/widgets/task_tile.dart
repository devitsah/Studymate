import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/study_task.dart';
import '../providers/task_provider.dart';

class TaskTile extends ConsumerWidget {
  final StudyTask task;
  final int index;
  
  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(
          task.subject,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '${task.topic} • ${task.dueDate.toLocal().toString().split(" ")[0]}',
        ),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (_) => ref.read(taskProvider.notifier).toggleComplete(index),
        ),
      ),
    );
  }
}
