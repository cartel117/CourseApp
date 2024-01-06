import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:course_app/DB/DatabaseHelper.dart';

class SubjectSystemViewModel with ChangeNotifier{
  List<Map<String, dynamic>> _courses = [];
  List<Map<String, dynamic>> get courses => _courses;
  List<Map<String, dynamic>> _selectedStudentCourses = [];
  List<Map<String, dynamic>> get selectedStudentCourses => _selectedStudentCourses;

  String _courseName = "文化課";
  String get courseName => _courseName;

  SubjectSystemViewModel() {
    print("SubjectSystemViewModel go ");
    initData();
  }

  void initData() async{
    List<Map<String, dynamic>> defalutCourses = await getCourses();
    print("defalutCourses ->$defalutCourses");

    // 取得該學生選得課程
    List<Map<String, dynamic>> studentCourses =
      await DatabaseHelper.instance.getStudentCoursesByStudentId(1);
    setSelectedStuSdentCourses(studentCourses);
  }

  void setCourses(List<Map<String, dynamic>> value) {
    _courses = value;
    notifyListeners();
  }

  void setSelectedStuSdentCourses(List<Map<String, dynamic>> value) {
    _selectedStudentCourses = value;
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