class UserNotSignedInError implements Exception {
  UserNotSignedInError();

  @override
  String toString() => 'User not signed in';
}

class DatabaseNotFoundException implements Exception {
  final String message;

  DatabaseNotFoundException(this.message);

  @override
  String toString() {
    return 'DatabaseNotFoundException: $message';
  }
}

class SystemStorageError implements Exception {
  SystemStorageError(this.message);
  final String message;

  @override
  String toString() => 'System storage error: $message';
}

// Used typically for getMany when we aren't able to return all the
// values
class DatabaseIncompleteException implements Exception {
  DatabaseIncompleteException(this.message);
  final String message;

  @override
  String toString() => 'GetManyIncompleteException: $message';
}
