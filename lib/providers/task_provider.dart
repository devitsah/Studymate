import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/study_task.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<StudyTask>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<StudyTask>> {
  TaskNotifier() : super(Hive.box('tasks').values.cast<StudyTask>().toList());

  void addTask(StudyTask task) {
    final box = Hive.box('tasks');
    box.add(task);
    state = box.values.cast<StudyTask>().toList();
  }

  void toggleComplete(int index) {
    final task = state[index];
    task.isDone = !task.isDone;
    task.save();
    state = [...state];
  }

  double get completionRate =>
      state.isEmpty ? 0 : state.where((t) => t.isDone).length / state.length;
}