import 'package:flutter/material.dart';
import 'package:isarapp/isarservice.dart';
import 'package:isarapp/mode/course.dart';
import 'package:isarapp/mode/student.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';



class StudentModal extends StatefulWidget {
  final IsarService service;

  const StudentModal(this.service, {Key? key}) : super(key: key);

  @override
  State<StudentModal> createState() => _StudentModalState();
}

class _StudentModalState extends State<StudentModal> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  List<Course> selectedCourses = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
      
          children: [
            Text("Give your new student a name",
                style: Theme.of(context).textTheme.headlineSmall),
            TextFormField(
              controller: _textController,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Student Name is not allowed to be empty";
                }
                return null;
              },
            ),
            FutureBuilder<List<Course>>(
              future: widget.service.getAllCourses(),
              
              builder: (context, AsyncSnapshot<List<Course>> snapshot) {
                if (snapshot.hasData) {
                  final courses = snapshot.data!.map((course) {
                    return MultiSelectItem<Course>(course, course.title??'');
                  }).toList();

                  return MultiSelectDialogField<Course>(
                      items: courses,
                      onConfirm: (value) {
                        selectedCourses = value;
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.service.saveStudent(
                      Student()
                        ..name = _textController.text
                        ..courses.addAll(selectedCourses),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "New student '${_textController.text}' saved in DB")),
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text("Add new student"))
          ],
        ),
      ),
    );
  }
}
