import 'dart:convert';
import 'package:course_app/Model/api_base.dart';
import 'package:http/http.dart' as http;

class HttpBase {
  Map<String, String> headers = {"Content-Type": "application/plain", "Accept": "*/*",};
  
  Future<ApiBase> get(String api, String ip, int port, int timeout, {bool isHttps = true, String credential = ""}) async { // ?? isHttps 真的有用 ??
    String uri = '${(isHttps ? "https://" : "http://")}$ip:$port$api'; // todo
    if (credential.isNotEmpty) headers['Authorization'] = 'Basic $credential';

    try { //can remove if http.get has exception protection 
      http.Response response = await http.get(
        Uri.parse(uri),
        headers: headers,
      ).timeout(
        Duration(milliseconds: timeout),
        onTimeout: () {return http.Response('timeout', 408);},
      );
      return _handleResponse(response);
    } 
    catch (e) {
      return ApiBase(status:"Get Request Exception",statusCode:999, message: e); 
    }
  }

  Future<ApiBase> post(String api, dynamic body, String ip, int port, int timeout, {bool isHttps = true, String credential = ""}) async {
    String uri = '${(isHttps ? "https://" : "http://")}$ip:$port$api'; // todo
    if (credential.isNotEmpty) headers['Authorization'] = 'Basic $credential';

    try { //can remove if http.get has exception protection 
      http.Response response = await http.post(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json", "Accept": "*/*"},
        body: body,
        ).timeout(
          Duration(milliseconds: timeout),
          onTimeout: () {return http.Response('timeout', 408);},
        ); 
      return _handleResponse(response);
    } 
    catch (e) {
      return ApiBase(status:"Post Request Exception",statusCode:999, message: e); 
    }
  }

   Future<ApiBase> put(String api, dynamic body, String ip, int port, int timeout, {bool isHttps = true, String credential = ""}) async {
    String uri = '${(isHttps ? "https://" : "http://")}$ip:$port$api'; // todo
    if (credential.isNotEmpty) headers['Authorization'] = 'Basic $credential';

    try { //can remove if http.get has exception protection 
      http.Response response = await http.put(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json", "Accept": "*/*"},
        body: body,
        ).timeout(
          Duration(milliseconds: timeout),
          onTimeout: () {return http.Response('timeout', 408);},
        ); 
      return _handleResponse(response);
    } 
    catch (e) {
      return ApiBase(status:"Post Request Exception",statusCode:999, message: e); 
    }
  }

  Future<ApiBase> delete(String api, String ip, int port, int timeout, {bool isHttps = true, String credential = ""}) async { // ?? isHttps 真的有用 ??
    String uri = '${(isHttps ? "https://" : "http://")}$ip:$port$api'; // todo
    if (credential.isNotEmpty) headers['Authorization'] = 'Basic $credential';

    try { //can remove if http.get has exception protection 
      http.Response response = await http.delete(
        Uri.parse(uri),
        headers: headers,
      ).timeout(
        Duration(milliseconds: timeout),
        onTimeout: () {return http.Response('timeout', 408);},
      );
      return _handleResponse(response);
    } 
    catch (e) {
      return ApiBase(status:"Get Request Exception",statusCode:999, message: e); 
    }
  }

  ApiBase _handleResponse(http.Response response) {
    final Map<String, dynamic> data = json.decode(response.body);

    return ApiBase(
      status: data['status'] ?? "",
      statusCode: data['statusCode'] ?? 404,
      message: data['data'],
    );
  }
}