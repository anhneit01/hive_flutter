import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  bool? isCompleted;
  @HiveField(3)
  String deadline;
  @HiveField(4)
  String startTime;
  @HiveField(5)
  String endTime;
  @HiveField(6)
  String? color;
  @HiveField(7)
  String? type;

  Task({
    required this.title, 
    this.isCompleted = false, 
    required this.deadline, 
    required this.startTime, 
    required this.endTime, 
    this.color
  });
}