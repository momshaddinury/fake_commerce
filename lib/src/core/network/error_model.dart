class ErrorResponseModel {
  ErrorResponseModel({
    this.error,
  });

  ErrorModel? error;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      error: json["error"] == null ? null : ErrorModel.fromJson(json["error"]),
    );
  }
}

class ErrorModel {
  ErrorModel({
    this.message = "Something went wrong! Please try again later.",
    this.code = "500",
    this.stack,
  });

  String? message;
  String? code;
  String? stack;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json["message"],
      code: json["code"],
      stack: json["stack"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "code": code,
      "stack": stack,
    };
  }
}
