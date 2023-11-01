import 'package:flutter/foundation.dart';

class Failure {
  final int? statusCode;
  final String message;
  final StackTrace? stackTrace;

  Failure({this.statusCode, required this.message, this.stackTrace}) {
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: message);
    }
  }
}
