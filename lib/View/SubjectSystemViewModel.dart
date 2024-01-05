import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:course_app/DB/DatabaseHelper.dart';

class SubjectSystemViewModel with ChangeNotifier{
  List<Map<String, dynamic>> _courses = [];
  List<Map<String, dynamic>> get courses => _courses;

  String _courseName = "文化課";
  String get courseName => _courseName;

  SubjectSystemViewModel() {
    print("SubjectSystemViewModel go ");
    initData();
  }

  void initData() async{
    List<Map<String, dynamic>> defalutCourses = await getCourses();
    print("defalutCourses ->$defalutCourses");
  }

  void setCourses(List<Map<String, dynamic>> value) {
    _courses = value;
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getCourses() async{
      // 讀取課程資料
  List<Map<String, dynamic>> course =
      await DatabaseHelper.instance.getDefaultInstructorCourses();
      setCourses(course);
      return course;
  }

}