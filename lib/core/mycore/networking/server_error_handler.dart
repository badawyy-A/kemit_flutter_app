
import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'server_error_model.dart';

enum DataSource {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int API_LOGIC_ERROR = 422; // API logic error

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT = ApiErrors.noContent;
  static const String BAD_REQUEST = ApiErrors.badRequestError;
  static const String UNAUTORISED = ApiErrors.unauthorizedError;
  static const String FORBIDDEN = ApiErrors.forbiddenError;
  static const String INTERNAL_SERVER_ERROR = ApiErrors.internalServerError;
  static const String NOT_FOUND = ApiErrors.notFoundError;

  // local status code
  static String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static String CANCEL = ApiErrors.defaultError;
  static String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static String SEND_TIMEOUT = ApiErrors.timeoutError;
  static String CACHE_ERROR = ApiErrors.cacheError;
  static String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ServerErrorModel getFailure() {
    return ServerErrorModel(
      errors: [
        ServerErrorDetail(
          type: "General",
          value: null,
          msg: _getMessage(),
          path: null,
          location: null,
        ),
      ],
    );
  }

  String _getMessage() {
    switch (this) {
      case DataSource.NO_CONTENT:
        return ResponseMessage.NO_CONTENT;
      case DataSource.BAD_REQUEST:
        return ResponseMessage.BAD_REQUEST;
      case DataSource.FORBIDDEN:
        return ResponseMessage.FORBIDDEN;
      case DataSource.UNAUTORISED:
        return ResponseMessage.UNAUTORISED;
      case DataSource.NOT_FOUND:
        return ResponseMessage.NOT_FOUND;
      case DataSource.INTERNAL_SERVER_ERROR:
        return ResponseMessage.INTERNAL_SERVER_ERROR;
      case DataSource.CONNECT_TIMEOUT:
        return ResponseMessage.CONNECT_TIMEOUT;
      case DataSource.CANCEL:
        return ResponseMessage.CANCEL;
      case DataSource.RECIEVE_TIMEOUT:
        return ResponseMessage.RECIEVE_TIMEOUT;
      case DataSource.SEND_TIMEOUT:
        return ResponseMessage.SEND_TIMEOUT;
      case DataSource.CACHE_ERROR:
        return ResponseMessage.CACHE_ERROR;
      case DataSource.NO_INTERNET_CONNECTION:
        return ResponseMessage.NO_INTERNET_CONNECTION;
      case DataSource.DEFAULT:
        return ResponseMessage.DEFAULT;
    }
  }
}

class ServerErrorHandler implements Exception {
  late ServerErrorModel serverErrorModel;

  ServerErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      serverErrorModel = _handleError(error);
    } else {
      serverErrorModel = DataSource.DEFAULT.getFailure();
    }
  }
}

ServerErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.data != null) {
        return ServerErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}