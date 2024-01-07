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

  void initData() {
    updateCourseViewData();
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
      // setCourses(course);
      return course;
  }

  void deleteStudentCourse(int courseID) async{
    await DatabaseHelper.instance.deleteStudentCourse(1,courseID);
    await updateCourseViewData();
  }

   void addStudentCourse(int courseID) async{
    await DatabaseHelper.instance.insertStudentCourse(1,courseID);
    await updateCourseViewData();
  }

  Future<void> updateCourseViewData() async{
    List<Map<String, dynamic>> defalutCourses = await getCourses();
    print("defalutCourses ->$defalutCourses");
    List<Map<String, dynamic>> copiedList = [];
  
    for (var i = 0; i < defalutCourses.length; i++){
      Map<String, dynamic> courseInfo = defalutCourses[i];
      Map<String, dynamic> newCourse = {};
      newCourse["course_name"] = courseInfo["course_name"];
      newCourse["course_id"] = courseInfo["course_id"];
      newCourse["instructor_id"] = courseInfo["instructor_id"];
      newCourse["course_description"] = courseInfo["course_description"];
      newCourse["start_date"] = courseInfo["start_date"].toString();
      newCourse["end_date"] = courseInfo["end_date"].toString();
      newCourse["isSelected"] = false;
      copiedList.add(newCourse);
      print("newCourse ->$newCourse");
      }

    // 取得該學生選得課程
    List<Map<String, dynamic>> studentCourses =
      await DatabaseHelper.instance.getStudentCoursesByStudentId(1);
    setSelectedStuSdentCourses(studentCourses);
    for (var defaultCourse in copiedList) {
      for (var studentCourse in studentCourses) {
        if (defaultCourse['course_name'] == studentCourse['course_name']) {
          defaultCourse['isSelected'] = true;
          break; // No need to continue searching for this defaultCourse
          }}
    }
    setCourses(copiedList);
  }

}