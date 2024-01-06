import 'package:course_app/Model/api_base.dart';
import 'package:course_app/utils/http_base.dart';
import 'package:course_app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import '../model/api_service_test.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([HttpBase]) // dart run build_runner build
void main() {
  group('ApiService', () {
    //Mock Inputs 
    final mockHttpBase = MockHttpBase(); 
    final apiService = ApiService(mockHttpBase); 

    test('test courseList function with get request', () async {
      // Mock return  data  
      Map<String, dynamic> fake_returnData = {
        "course_id": 1, 
        "instructor_id": 1, 
        "course_name": "Flutter Basics", 
        "course_description": "Introduction to Flutter development", 
        "start_date": "2022-01-01", 
        "end_date": "2022-02-09"};
      when(mockHttpBase.get(any, any, any, any)).thenAnswer((_) async => 
        ApiBase(status: 'ok', statusCode: 200, message:fake_returnData));

      //Execute courseList Function 
      final apiResponse = await apiService.courseList("192.168.0.2"); 

      // Assert
      expect(apiResponse, isNotNull);
      expect(apiResponse.status, 'ok');
      expect(apiResponse.statusCode, 200); 
      expect(apiResponse.message, equals({
        "course_id": 1, 
        "instructor_id": 1, 
        "course_name": "Flutter Basics", 
        "course_description": "Introduction to Flutter development", 
        "start_date": "2022-01-01", 
        "end_date": "2022-02-09"}));
    });

    test('test instructorList function with get request', () async {
      // Mock return  data  
      Map<String, dynamic> fake_returnData = {
        "instructor_id": 3, 
        "instructor_name": "Andy", 
        "instructor_description": "專門教C++"};
      when(mockHttpBase.get(any, any, any, any)).thenAnswer((_) async => 
        ApiBase(status: 'ok', statusCode: 200, message:fake_returnData));

      //Execute instructorList Function 
      final apiResponse = await apiService.instructorList("192.168.0.3"); 

      // Assert
      expect(apiResponse, isNotNull);
      expect(apiResponse.status, 'ok');
      expect(apiResponse.statusCode, 200); 
      expect(apiResponse.message, equals( {
        "instructor_id": 3, 
        "instructor_name": "Andy", 
        "instructor_description": "專門教C++"}));
    });

    test('test createNewCourse function with get request', () async {
      // Mock return data  
      Map<String, dynamic> fake_returnData = {
        "course_id": 10, 
        "course_name": "How to use AI", 
        "course_description": "簡介AI和如何訓練資料"};
      Map<String, dynamic> fake_postData ={"course_name": "How to use AI"};        
      when(mockHttpBase.post(any, any, any, any, any)).thenAnswer((_) async => 
        ApiBase(status: 'ok', statusCode: 200, message:fake_returnData));

      //Execute createNewCourse Function 
      final apiResponse = await apiService.createNewCourse("192.168.0.3",fake_postData); 

      // Assert
      expect(apiResponse, isNotNull);
      expect(apiResponse.status, 'ok');
      expect(apiResponse.statusCode, 200); 
      expect(apiResponse.message, equals({
        "course_id": 10, 
        "course_name": "How to use AI", 
        "course_description": "簡介AI和如何訓練資料"}));
    });
  }); 
}