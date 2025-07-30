class UserNotSignedInError implements Exception {
  UserNotSignedInError();

  @override
  String toString() => 'User not signed in';
}
