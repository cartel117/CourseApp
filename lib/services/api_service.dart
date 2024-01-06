import 'package:course_app/Model/api_base.dart';
import 'package:course_app/utils/http_base.dart';
import 'package:logger/logger.dart';

class ApiService {
  HttpBase httpClient;
  final tag = 'apiService';
  Logger logger = Logger();
  
  ApiService(this.httpClient);
  // Add more methods for other API calls

  //課程列表 API (Read)
  Future<ApiBase> courseList(String ip) async {
     const String endpoint = '/courses';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.get(endpoint, ip, port, 5000);
  }

  //授課講師列表 API (Read)
  Future<ApiBase> instructorList(String ip) async {
     const String endpoint = '/instructors';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.get(endpoint, ip, port, 5000);
  }

  //授課講師所開課程列表 API (Read)
  Future<ApiBase> instructorCoursesList(String ip) async {
     const String endpoint = '/instructor/courses';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.get(endpoint, ip, port, 5000);
  }

  //建立新講師 API (Create)
  Future<ApiBase> createNewInstructor(String ip,Map<String, dynamic> requestData) async {
     const String endpoint = '/instructor/add';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.post(endpoint, requestData, ip, port, 5000);
  }

  //建立新課程 API (Create) 
  Future<ApiBase> createNewCourse(String ip,Map<String, dynamic> requestData) async {
     const String endpoint = '/course/add';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.post(endpoint, requestData, ip, port, 5000);
  }

  //更新課程內容 API (Update)
  Future<ApiBase> updateCourse(String ip,Map<String, dynamic> requestData) async {
     const String endpoint = '/course/add';
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.put(endpoint, requestData, ip, port, 5000);
  }

  //刪除課程 API (Delete)
  Future<ApiBase> deleteCourse(String ip,int courseID) async {
     String endpoint = "/course/$courseID";
     const int port = 28443;
     // Make the API call using the HttpBase instance
    return await httpClient.delete(endpoint, ip, port, 5000);
  }
}
