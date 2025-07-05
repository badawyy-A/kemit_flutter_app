class ApiConstants {
  static const String apiBaseUrl = "https://kemet-nu.vercel.app/";
  static const String login = "auth/login";
  static const String signUp = "auth/signup";
  static const String verifyAccount = "auth/verifyEmailUser";
  static const String forgetPassword = "auth/forgetpass";
  static const String verifyPassword = "auth/verifycode";
  static const String resetPassword = "auth/resetpassword";
  static const String updateUser = "users/updateMe";
  static const String createReport = "report";
  static const String updateReport = "report/{id}";
  static const String updatePassword = "users/updateUserPassword";
  static const String getPlaces = "place";
  static const String getNerestPlaces = "place/near";
}

class ApiErrors {
  static const String badRequestError = "Bad Request Error";
  static const String noContent = "No Content";
  static const String forbiddenError = "Forbidden Error";
  static const String authenticationError = "Authentication Error";
  static const String notFoundError = "Not Found Error";
  static const String conflictError = "Conflict Error";
  static const String internalServerError = "Internal Server Error";
  static const String unknownError = "Unknown Error";
  static const String timeoutError = "Timeout Error";
  static const String defaultError = "Default Error";
  static const String cacheError = "Cache Error";
  static const String noInternetError = "No Internet Error";
  static const String loadingMessage = "Loading_Message";
  static const String retryAgainMessage = "Retry_Again_ Message";
  static const String unauthorizedError = "Unauthorized Error";
  static const String ok = "OK";
}
