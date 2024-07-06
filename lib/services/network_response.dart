/// Type T refers to the API response Type
class NetworkResponse<T extends Object?> {
  bool isSuccess;
  T response;
  String? errorMsg;

  NetworkResponse(this.isSuccess, this.response);

  NetworkResponse.success(this.response)
      : isSuccess = true,
        errorMsg = null;

  NetworkResponse.error(this.errorMsg,
      {this.isSuccess = false,  required this.response});
}

class ApiResponse {
  int? status;
  String? details;
  dynamic data;
  String? message;

  ApiResponse(this.status, this.details, this.data, this.message);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        json['status'], json['details'], json['data'], json['message']);
  }
}
