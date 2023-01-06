
import 'package:isar/isar.dart';
import 'package:isarapp/mode/student.dart';
import 'package:isarapp/mode/teacher.dart';
part 'course.g.dart';

@Collection()

class Course{
Id id=Isar.autoIncrement;
 String? title;
 @Backlink(to: "courses")
final student=IsarLinks<Student>();
  @Backlink(to: "course")
  final teacher=IsarLink<Teacher>();
}

