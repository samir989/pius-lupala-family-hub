import 'package:firebase_core/firebase_core.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);
  @override
  String toString() => message;
}

Never _throw(Object error) {
  if (error is FirebaseException) {
    throw AppException(error.message ?? error.code);
  }
  throw AppException(error.toString());
}

Future<T> guardFirebase<T>(Future<T> Function() action) async {
  try {
    return await action();
  } catch (error) {
    _throw(error);
  }
}
