
import 'package:isar/isar.dart';
import 'package:isarapp/mode/course.dart';

part 'student.g.dart';

@Collection()
class Student{
Id id=Isar.autoIncrement;
late String name;
final courses=IsarLinks<Course>();
}
