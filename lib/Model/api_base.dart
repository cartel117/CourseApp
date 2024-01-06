class ApiBase {
  final String status; // "ok", "timeout", "error"
  final int statusCode; // 200, 500
  dynamic data;

  ApiBase({
    required this.status,
    required this.statusCode,
    this.data,
  });

  // Factory constructor for creating an instance from JSON
  factory ApiBase.fromJson(Map<String, dynamic> json) {
    return ApiBase(
      status: json['status'] ?? "",
      statusCode: json['statusCode'] ?? 404,
      data: json['data'],
    );
  }

  // Method for converting the instance to JSON
  Map<String, dynamic> toJson() => {
        'status': status,
        'statusCode': statusCode,
        'data': data,
      };
}