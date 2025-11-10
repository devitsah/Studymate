import 'package:hive/hive.dart';

part 'study_task.g.dart';

@HiveType(typeId: 1)
class StudyTask extends HiveObject {
  @HiveField(0)
  String subject;

  @HiveField(1)
  String topic;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isDone;

  StudyTask({
    required this.subject,
    required this.topic,
    required this.dueDate,
    this.isDone = false,
  });
}