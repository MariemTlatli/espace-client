class ErrorModel {
  final bool error;
  final String errorMessage;

  ErrorModel({required this.error, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      error: jsonData["error"],
      errorMessage: jsonData["message"],
    );
  }
}
