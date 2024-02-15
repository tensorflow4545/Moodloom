class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, 'No internet');
}

class SocketException extends AppException {
  SocketException([String? message]) : super(message, 'server down');
}

class RequestTimeout extends AppException {
  RequestTimeout([String? message]) : super(message, 'Time Out');
}

class ServeException extends AppException {
  ServeException([String? message]) : super(message, 'Server down');
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message, 'Invalid Url');
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Unable to fetch data');
}
