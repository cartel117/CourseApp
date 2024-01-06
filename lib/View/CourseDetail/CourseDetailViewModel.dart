import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:course_app/DB/DatabaseHelper.dart';

class CourseDetailViewModel with ChangeNotifier{
  Map<String, dynamic> courseInfo = {};
  CourseDetailViewModel(this.courseInfo) {
    initData();
  }

  String _courseName = "";
  String get courseName => _courseName;
  String _courseDescription = "";
  String get courseDescription => _courseDescription;
  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;
  DateTime _endDate = DateTime.now();
  DateTime get endDate => _endDate;
  String _startDateStr = "";
  String get startDateStr => _startDateStr;
  String _endDateStr = "";
  String get endDateStr => _endDateStr;
  int _instructorID = 0 ;
  int get instructorID => _instructorID;

  Map<String, dynamic>? _instructorInfo = {};
  Map<String, dynamic>? get instructorInfo => _instructorInfo;

  List<Map<String, dynamic>> _instructorCourses = [];
  List<Map<String, dynamic>> get instructorCourses => _instructorCourses;

  void setCourseName(String value) {
    _courseName = value;
    notifyListeners();
  }

  void setCourseDescription(String value) {
    _courseDescription = value;
    notifyListeners();
  }

  void setStartDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  void setEndDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  void setStartDateStr(String value) {
    _startDateStr = value;
    notifyListeners();
  }

  void setEndDateStr(String value) {
    _endDateStr = value;
    notifyListeners();
  }

  void setInstructorID(int value) {
    _instructorID = value;
    notifyListeners();
  }

  void setInstructorInfo(Map<String, dynamic>? value) {
    _instructorInfo = value;
    notifyListeners();
  }

  void setInstructorCourses(List<Map<String, dynamic>> value) {
    _instructorCourses = value;
    notifyListeners();
  }

  void initData() async{
    String courseName = courseInfo["course_name"];
    String courseDescription = courseInfo["course_description"];
    String startDT_String = courseInfo["start_date"];
    String endDT_String = courseInfo["end_date"];
    DateTime startDT = DateTime.parse(startDT_String);
    DateTime endDT = DateTime.parse(endDT_String);
    int instructor_id = courseInfo["instructor_id"];
    setCourseName(courseName);
    setCourseDescription(courseDescription);
    setStartDate(startDT);
    setEndDate(endDT);
    setStartDateStr(startDT_String);
    setEndDateStr(endDT_String);
    setInstructorID(instructor_id);

    Map<String, dynamic>? specifiedInstructor =
      await DatabaseHelper.instance.getInstructorById(instructor_id);
    setInstructorInfo(specifiedInstructor);

    // 取得指定 instructor_id 的講師所教的課程
    List<Map<String, dynamic>> courses =
        await DatabaseHelper.instance.getCoursesByInstructorId(instructor_id);
    setInstructorCourses(courses);
  }

}