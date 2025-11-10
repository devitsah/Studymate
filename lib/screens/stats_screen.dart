import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/task_provider.dart';
import '../models/study_task.dart';

enum Priority { low, medium, high }

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final completed = tasks.where((t) => t.isDone).length;
    final remaining = tasks.length - completed;
    final completionRate = ref.read(taskProvider.notifier).completionRate;

    return Scaffold(
      appBar: AppBar(title: const Text("Progress Overview")),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No data to display yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Total Tasks: ${tasks.length}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: completed.toDouble(),
                            color: Colors.green,
                            title: 'Done\n$completed',
                          ),
                          PieChartSectionData(
                            value: remaining.toDouble(),
                            color: Colors.orange,
                            title: 'Pending\n$remaining',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: completionRate,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${(completionRate * 100).toStringAsFixed(1)}% Complete',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
    );
  }
}
